// Link-preview images (Open Graph), 1200 × 630 px: a point is a pixel at the
// 72 ppi the Makefile renders at. `--input kind=` picks the card: site, cv-en
// or cv-ru.
//
// The cards hold only what does not go stale: face, name, role, where, and the
// address. Chats and social networks cache a preview for months and are hard to
// refresh, so a number or an employer here would outlive its truth.

#let kind = sys.inputs.at("kind", default: "site")

#let serif = "Libertinus Serif"
#let sans = "Inter"
// The name is set as the landing page sets its heading: Charter, bold. XCharter
// is the free Bitstream Charter, kept in fonts/ so the build does not depend on
// the copy macOS ships.
#let display = "XCharter"
#let ink = rgb("#1a1a1a")
#let muted = rgb("#565656")
#let rule-colour = rgb("#d8d8d8")
#let link-colour = rgb("#1a4f8a")

#set page(width: 1200pt, height: 630pt, margin: 0pt, fill: rgb("#fdfdfc"))
#set text(font: serif, fill: ink, hyphenate: false)

#let portrait(size) = box(
  width: size, height: size, radius: 50%, clip: true,
  image("public/photo.jpeg", width: size, height: size, fit: "cover"),
)

#if kind == "site" {
  place(center + horizon, grid(
    columns: 2, column-gutter: 80pt, align: horizon,
    portrait(340pt),
    stack(spacing: 28pt,
      text(font: display, size: 104pt, weight: "bold")[Ilya Mois],
      text(font: sans, size: 40pt, weight: "semibold", fill: link-colour)[mois.pro],
    ),
  ))
} else {
  let ru = kind == "cv-ru"
  set text(lang: if ru { "ru" } else { "en" })
  pad(x: 96pt, top: 64pt, bottom: 64pt, block(height: 100%, {
    v(1fr)
    grid(
      columns: (1fr, auto), align: horizon,
      stack(spacing: 22pt,
        text(font: sans, size: 22pt, weight: "semibold", fill: muted)[#if ru [РЕЗЮМЕ] else [CV]],
        text(font: display, size: 84pt, weight: "bold")[Ilya Mois],
        text(size: 38pt)[Senior Full-Stack Engineer],
        text(size: 28pt, fill: muted)[#if ru [Удалённо или в офисе в Тбилиси, Грузия (GMT+4)] else [Remote or on-site in Tbilisi, Georgia (GMT+4)]],
      ),
      portrait(240pt),
    )
    v(1fr)
    line(length: 100%, stroke: 1pt + rule-colour)
    v(20pt)
    grid(
      columns: (1fr, auto),
      text(font: sans, size: 24pt, weight: "semibold", fill: link-colour)[#if ru [mois.pro/cv/ru] else [mois.pro/cv]],
      text(size: 26pt, fill: muted)[#if ru [Веб · PDF · English] else [Web · PDF · По-русски]],
    )
  }))
}
