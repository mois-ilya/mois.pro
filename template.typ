// Typst template for the CV. Used by pandoc as --template.
//
// Everything about how the document looks lives here; index.md holds nothing
// but content and the contact metadata at its top. Fonts are restricted to the
// ones compiled into the typst binary, so the build does not depend on what
// happens to be installed on the machine that runs it.

#let body-font = "Libertinus Serif"
#let mono-font = "DejaVu Sans Mono"
#let muted = rgb("#555555")
#let rule-colour = rgb("#c8c8c8")
#let link-colour = rgb("#1a4f8a")

// Title and author are content, not strings: pandoc writes an em dash as the
// typst markup `---`, which only becomes a dash when interpreted as content.
#set document(title: [$title$], author: "$author$")

#set page(
  paper: "a4",
  margin: (x: 17mm, top: 16mm, bottom: 16mm),
)

#set text(
  font: body-font,
  size: 10pt,
  lang: "$if(lang)$$lang$$else$en$endif$",
  hyphenate: false,
)
#set par(justify: false, leading: 0.6em, spacing: 0.75em)
#show raw: set text(font: mono-font, size: 9pt)

#show link: set text(fill: link-colour)

// The meta line under each job heading — dates, location, context.
// Only the colour is set here: emph toggles the style rather than setting it,
// so asking for italic as well would flip it back to upright.
#show emph: set text(fill: muted)

// Section headings. `sticky` keeps a heading attached to what follows it, so
// none can be stranded at the foot of a page.
#show heading.where(level: 1): it => block(above: 1.4em, below: 0.55em, sticky: true, width: 100%)[
  // No letter-spacing here: tracking widens the gaps enough that pdftotext
  // reads "EXPERIENCE" as "EX PERI ENCE", and a parser looking for section
  // names never finds it.
  #set text(size: 10pt, weight: "bold")
  #upper(it.body)
  #v(-0.4em)
  #line(length: 100%, stroke: 0.5pt + rule-colour)
]

// Job and degree headings.
#show heading.where(level: 2): it => block(above: 0.95em, below: 0.3em, sticky: true)[
  #set text(size: 10.5pt, weight: "bold")
  #it.body
]

#set list(marker: [·], indent: 0.1em, body-indent: 0.5em, spacing: 0.5em)

// Header block: name, then the one-line pitch, then contacts.
#block(below: 1.3em)[
  #text(size: 21pt, weight: "bold")[$author$]
  #v(0.3em)
  #text(size: 10.5pt)[$headline$]
  #v(0.15em)
  #text(size: 9pt, fill: muted)[$contact$]
]

$body$
