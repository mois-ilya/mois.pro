# Repository instructions

## What this is

This is the source of [mois.pro](https://mois.pro): a personal site and a CV built from one set of
source files. The output is entirely static. Pandoc renders Markdown, Typst makes the PDFs, and no
application code runs when the site handles a request.

## Build and verify

```sh
make          # build both PDFs into dist/
make site     # build the whole site into dist/
make serve    # preview at http://localhost:8000
make check    # validate both PDFs; run before calling a CV change done
make deploy   # build and publish to the live domain
```

Only run `make deploy` when the user explicitly asks to publish or deploy.

## Project constraints

**Do not add JavaScript.** This is a deliberate property of the site, not a framework preference.
Do not add analytics snippets, theme switchers, or client-side dependencies. Rethink anything that
appears to require JavaScript.

**Keep `src/index.html` as hand-written HTML.** It is a layout, not a document. The projects page
and both CV editions are documents and remain Markdown.

**Keep `-f markdown-citations` in the Pandoc commands.** Without it, `@tonconnect/sdk` in the CV is
parsed as a citation and the build fails. `--shift-heading-level-by=-1` belongs to the CV builds
only; the projects page already uses the correct heading levels.

**Keep the CV one column.** A previous two-column layout produced a scrambled text layer in which
dates were detached from their employers. `check-pdf.sh` verifies the employer/date order in both
languages so this cannot regress quietly.

**Keep generated output in `dist/`.** PDFs include a Typst build timestamp, so their bytes change
on every build even when their text does not. `dist/` is ignored. Never copy generated PDFs back
into the tracked repository root.

**Treat job-search copy as a build-time variant.** `site.conf` is the source of truth. Set
`LOOKING_FOR_WORK := false` to omit every block between the `job-search` markers. When it is true,
update `JOB_SEARCH_UPDATED` together with the status.

**Measure layout at the real viewport.** Do not infer production geometry from a zoomed screenshot.
Load the built page at the target viewport and inspect its DOM geometry.

## Deployment

`mois.pro` and `www.mois.pro` are custom domains on a Cloudflare Workers Static Assets project.
`wrangler.jsonc` defines both domains and the URL handling that lets `/cv` answer directly rather
than redirecting to `/cv/`.

## Instruction files

`AGENTS.md` is the canonical repository instruction file. `CLAUDE.md` imports it for Claude Code.
Keep shared instructions here instead of duplicating them between harness-specific files.
