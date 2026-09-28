// Typst template for the CV. Used by pandoc as --template.
//
// Everything about how the document looks lives here; index.md holds nothing
// but content and the contact metadata at its top. The body is Libertinus
// Serif, compiled into the typst binary; headings are Inter, whose one face
// lives in fonts/ and reaches typst through --font-path. Nothing depends on
// what happens to be installed on the machine that runs the build.

#let body-font = "Libertinus Serif"
#let head-font = "Inter"
#let muted = rgb("#555555")
#let rule-colour = rgb("#c8c8c8")
#let link-colour = rgb("#1a4f8a")

// Title and author are content, not strings: pandoc writes an em dash as the
// typst markup `---`, which only becomes a dash when interpreted as content.
#set document(title: [$title$], author: "$author$")

#set page(
  paper: "a4",
  margin: (x: 21mm, top: 16mm, bottom: 15mm),
)

#set text(
  font: body-font,
  size: 10.3pt,
  lang: "$if(lang)$$lang$$else$en$endif$",
  hyphenate: false,
)
// Paragraph spacing is set for the Summary, the only place with two
// paragraphs in a row; at the old 0.95em they read as one block. Lists and
// the header set their own, tighter spacing below.
#set par(justify: false, leading: 0.6em, spacing: 1.35em)
// Inline code is set in the body font: a monospace face in running text made
// every identifier a dark blot. Typst shrinks raw text to 0.8em; undo that.
#show raw: set text(font: body-font, size: 1em / 0.8)

#show link: set text(fill: link-colour)

// The meta line under each job heading — dates, location, context.
// Only the colour is set here: emph toggles the style rather than setting it,
// so asking for italic as well would flip it back to upright.
#show emph: set text(fill: muted)
// The meta line is the only italic in the CV, so it can be made sticky too:
// the heading already keeps to it, and it now keeps to the first bullet, so a
// job's heading and dates never sit alone at the foot of a page.
#show emph: it => block(sticky: true, it)

// Section headings. `sticky` keeps a heading attached to what follows it, so
// none can be stranded at the foot of a page.
#show heading.where(level: 1): it => block(above: 1.6em, below: 0.65em, sticky: true, width: 100%)[
  // No letter-spacing here: tracking widens the gaps enough that pdftotext
  // reads "EXPERIENCE" as "EX PERI ENCE", and a parser looking for section
  // names never finds it.
  #set text(font: head-font, size: 8.8pt, weight: "semibold", fill: muted)
  #upper(it.body)
  #v(-0.4em)
  #line(length: 100%, stroke: 0.5pt + rule-colour)
]

// Job and degree headings.
#show heading.where(level: 2): it => block(above: 1.15em, below: 0.35em, sticky: true)[
  #set text(font: head-font, size: 10.1pt, weight: "semibold")
  #it.body
]

// The gap between bullets is wider than the line spacing inside one; when the
// two were equal, a page of bullets read as one undivided block.
#set list(marker: text(fill: muted)[•], indent: 0.1em, body-indent: 0.6em, spacing: 0.8em)
// Keep a job's bullets close to its date line despite the wider paragraph gap.
#show list: set block(above: 0.6em, below: 0.6em)

// Header block: name, then the one-line pitch, then contacts.
#block(below: 1.3em)[
  #set par(spacing: 0.65em)
  #text(font: head-font, size: 20pt, weight: "semibold")[$author$]
  #v(0.3em)
  #text(size: 10.5pt)[$headline$]
  #v(0.15em)
  #text(size: 9pt, fill: muted)[$contact$]
]

$body$
