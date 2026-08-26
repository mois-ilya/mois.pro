# CLAUDE.md

Notes for [Claude Code](https://claude.com/claude-code), which is what this site was built with.

## What this is

The source of mois.pro: a personal site and a CV, from one set of Markdown files. Static output
only — `pandoc` renders the Markdown, `typst` makes the PDFs, and nothing runs on a request.

## Build and verify

```
make          both PDFs
make site     the whole site into dist/
make serve    preview at http://localhost:8000
make check    run this before calling a change to the CV done
make deploy   publishes to the live domain — confirm before running it
```

## Things that will bite you

**No JavaScript, anywhere.** Not a preference — the reason is in README.md. Do not add a theme
switcher, an analytics snippet, or a framework. If something seems to need JS, it needs rethinking
instead.

**`src/index.html` is hand-written HTML and stays that way.** It is a layout, not a document.
Everything else is Markdown and should be.

**`pandoc` needs `-f markdown-citations`.** Without it `@tonconnect/sdk` in the CV parses as a
citation and the build fails. `--shift-heading-level-by=-1` belongs to the PDF builds only; the
projects page is already written at the right level.

**The CV must stay one column.** A two-column version broke `pdftotext`, which emitted every
employer and date detached from the job it belonged to. `check.sh` asserts that each employer
heading is still followed by its own dates, in both languages, so the regression cannot return
quietly.

**`make` leaves both PDFs byte-different but text-identical**, because `typst` stamps a build
time. Unless the text actually changed, restore them with `git checkout --` rather than committing
the churn.

**The status line in `src/index.html` is the one sentence that goes stale.** It carries a month.
Change both together, or neither.

**Measure layout, do not eyeball it.** Every layout claim in this repo's history that turned out
wrong was wrong because someone looked at a picture instead of taking a number — a favicon judged
at 5x magnification, a hero checked at a desktop width. Load the built page at the real viewport
and read the geometry out of the DOM.

## Deployment

`mois.pro` and `www.mois.pro` are custom domains on a Cloudflare Workers static-assets project;
`wrangler.jsonc` holds both, and the URL handling that keeps `/cv` answering directly instead of
redirecting to `/cv/`.
