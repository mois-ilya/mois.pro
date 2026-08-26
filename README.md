# mois.pro

The source of **[mois.pro](https://mois.pro)** — my personal site and my CV, from one set of
Markdown files. `pandoc` and `typst` build it, and nothing runs on a request: no JavaScript on any
page, and no Worker script behind the domain, only static assets.

```
make          # -> Ilya-Mois-CV.pdf, Ilya-Mois-CV-ru.pdf   for attaching to an application
make site     # -> dist/                                    the whole site
make serve    # preview dist/ at http://localhost:8000
make check    # assert each PDF is sane before sending it
make deploy   # build and publish to Cloudflare
make watch    # rebuild the PDFs whenever a source changes
make clean
```

## Setup

```
brew install pandoc typst poppler
```

No runtime, nothing to compile. `poppler` is only needed for `make check`, `wrangler` only for
`make deploy`.

## What is where

| | |
|---|---|
| `src/cv.md`, `src/cv.ru.md` | the CV, English and Russian — the source of truth |
| `src/index.html` | the landing page |
| `src/projects.md` | the projects list |
| `template.typ` | every layout decision for the PDF |
| `template.html` | the wrapper for the pages built from Markdown |
| `filters/` | pandoc filters — currently one, sending outbound links to a new tab |
| `assets/` | `tokens.css` (colours), `site.css` (landing), `page.css` (documents) |
| `public/` | copied to the root of the site: the portrait and the icons |
| `wrangler.jsonc` | how Cloudflare serves it — the domains, and the URL shapes |
| `check.sh` | what `make check` runs |
| `CLAUDE.md` | notes for Claude Code, which this was built with |

`pandoc` reads the Markdown and renders it either through `template.typ`, compiled by `typst` into
a PDF, or through `template.html` into a page. Fonts are limited to the ones compiled into the
`typst` binary, so the PDF does not depend on what happens to be installed on the machine doing
the build.

The PDFs are committed at the repo root, so they can be downloaded from GitHub without building
anything; `make site` copies them into `dist/` alongside the pages.

## Why it looks like this

**The landing page is hand-written HTML.** Everything else here is Markdown, and it should be —
but the first screen is a layout, not a document, and running it through a Markdown pipeline would
mean inventing markup to express a layout Markdown has no words for. A hundred lines of semantic
HTML for a page that changes twice a year is the smaller cost.

**No JavaScript, anywhere.** There is nothing on this site to interact with, and a page made of
text and links should not ask the reader to execute code to see it. Following from that, the
colours follow `prefers-color-scheme` and there is no theme switcher: a switcher needs JavaScript
and local storage, and flashes the wrong theme while it loads.

**The tab icon is a letter, the home-screen icon is the photo.** At 16px a face is a smudge, so the
favicon is an `M` in Charter — the serif the site is set in — which holds on a light tab strip and a
dark one. At 180px the photo is plainly better, and a letter there would be a brand mark for a site
with no brand.

**The CV exists in two editions; the landing page does not.** Each edition declares the whole set
with `rel="alternate"`, itself included, so a search engine reads them as one document in two
languages rather than as duplicates. The landing stays English only on purpose: a CV is facts, so a
translation either matches or is demonstrably wrong and `make check` runs over both, while the
landing is voice — a second voice is a second thing to keep true, and nothing detects when it
stops being true.

**The CV is a single column, deliberately.** An earlier version of this repo used a two-column
design with dates in a left gutter. It read well on screen, but the text layer of the resulting
PDF came out in the wrong order: `pdftotext` treated the gutter as a separate column and emitted
every employer and date as a detached block *before* the work it belonged to, so anything parsing
the file attached the wrong dates to the wrong job. Flattening the layout fixed the extraction and
dropped the document from three pages to two.

`make check` exists so that regression cannot come back unnoticed. It verifies page count and
paper size, that the PDF is tagged, that fonts are embedded, that the metadata title is clean — it
becomes the default attachment filename — and, most importantly, that each employer heading is
still immediately followed by its own dates when the text is extracted. Section names and date
formats are read from the source, so the same script checks both languages.
