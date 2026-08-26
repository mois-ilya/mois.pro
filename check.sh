#!/bin/bash
# Assert the built PDF is what we think it is, before it gets attached to an
# application. Every check here corresponds to something that has actually gone
# wrong with this document at some point.
#
#   ./check.sh Ilya-Mois-CV.pdf src/cv.md
#
# Section names and date formats are read from the source rather than hardcoded,
# so this works for any language the CV is written in.
#
# Needs poppler (brew install poppler).

set -uo pipefail

PDF="${1:-Ilya-Mois-CV.pdf}"
SRC="${2:-src/cv.md}"
fail=0

# Month names that may open a date line, in any language the CV is written in.
MONTHS='Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec'
MONTHS="$MONTHS|янв|фев|мар|апр|ма[йя]|июн|июл|авг|сен|окт|ноя|дек"

say() { printf '%-58s %s\n' "$1" "$2"; }
ok()   { say "$1" "ok"; }
bad()  { say "$1" "FAIL — $2"; fail=1; }

[ -f "$PDF" ] || { echo "no such file: $PDF"; exit 1; }

info=$(pdfinfo "$PDF")
text=$(pdftotext "$PDF" -)
raw=$(pdftotext -raw "$PDF" -)

# --- the document itself -----------------------------------------------------

pages=$(printf '%s' "$info" | awk '/^Pages:/ {print $2}')
if [ "$pages" -le 2 ]; then ok "fits in two pages ($pages)"
else bad "fits in two pages" "$pages pages"; fi

if printf '%s' "$info" | grep -q 'A4'; then ok "A4 paper"
else bad "A4 paper" "$(printf '%s' "$info" | awk -F': +' '/^Page size:/ {print $2}')"; fi

if printf '%s' "$info" | grep -q '^Tagged: *yes'; then ok "tagged PDF (structure tree present)"
else bad "tagged PDF" "no structure tree — extraction falls back to geometry"; fi

title=$(printf '%s' "$info" | sed -n 's/^Title: *//p')
case "$title" in
  *'|'*|'') bad "clean metadata title" "'$title' — becomes the attachment filename" ;;
  *)        ok "clean metadata title ('$title')" ;;
esac

# Fonts must be embedded, or the reviewer's machine substitutes its own.
# The "type" column contains spaces ("CID Type 0C"), so count fields from the
# right instead: object ID takes two, then uni, sub, and emb.
if pdffonts "$PDF" | tail -n +3 | awk 'NF && $(NF-4) != "yes"' | grep -q .; then
  bad "all fonts embedded" "$(pdffonts "$PDF" | tail -n +3 | awk 'NF && $(NF-4) != "yes" {print $1}' | tr '\n' ' ')"
else ok "all fonts embedded ($(pdffonts "$PDF" | tail -n +3 | grep -c .) faces)"; fi

# --- what a parser makes of it ----------------------------------------------

# Every employer heading must be followed immediately by its date line. This is
# the failure the old two-column layout had: dates detached into a block of
# their own and got attached to the wrong job.
while IFS= read -r org; do
  next=$(printf '%s\n' "$text" | grep -A1 -F "$org" | tail -1)
  if printf '%s' "$next" | grep -qE "^($MONTHS|[0-9]{4})"; then
    ok "dates follow '$(printf '%s' "$org" | cut -c1-28)'"
  else
    bad "dates follow '$(printf '%s' "$org" | cut -c1-28)'" "got: $(printf '%s' "$next" | cut -c1-40)"
  fi
done < <(grep -E '^### ' "$SRC" | sed 's/^### //')

# Section names must survive extraction as single words. Letter-spacing once
# turned EXPERIENCE into "EX PERI ENCE".
while IFS= read -r section; do
  if printf '%s' "$text" | grep -qx "$section"; then ok "section '$section' extracts intact"
  else bad "section '$section' extracts intact" "not found on a line of its own"; fi
done < <(grep -E '^## ' "$SRC" | sed 's/^## //' | perl -CS -ne 'print uc')

# Hyphenated terms must not lose their hyphen when a line breaks inside them, or
# a keyword search for the real term misses. The terms come from the source, so
# this keeps working as the text changes and whatever language it is in.
lost=""
while IFS= read -r term; do
  squashed=${term//-/}
  # Only a loss if the squashed form turned up and the hyphenated one did not;
  # otherwise the two are simply different strings that both occur.
  if printf '%s' "$raw" | grep -qF "$squashed" && ! printf '%s' "$raw" | grep -qF "$term"; then
    lost="$lost $term"
  fi
done < <(sed -e 's/](\([^)]*\))/]/g' -e 's#https\{0,1\}://[^ )]*##g' "$SRC" \
         | grep -ohE '[[:alnum:]]{3,}-[[:alnum:]]{3,}' | sort -u)
if [ -n "$lost" ]; then bad "hyphenated terms keep their hyphens" "lost:$lost"
else ok "hyphenated terms keep their hyphens"; fi

# The two extractors must agree on word count; a large gap means the geometry is
# doing something one of them cannot follow.
a=$(printf '%s' "$text" | wc -w | tr -d ' ')
b=$(printf '%s' "$raw" | wc -w | tr -d ' ')
diff=$(( a > b ? a - b : b - a ))
if [ "$diff" -le 5 ]; then ok "both extractors agree ($a / $b words)"
else bad "both extractors agree" "$a vs $b words"; fi

echo
if [ "$fail" -eq 0 ]; then echo "PDF is good to send."; else echo "Do not send this file yet."; fi
exit $fail
