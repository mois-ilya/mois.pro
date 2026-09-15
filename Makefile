# Build mois.pro and the CV. Requires pandoc and typst; `make check` also needs
# poppler, and `make deploy` needs wrangler.
#
#   make            -> both PDFs in dist/, ready to attach to an application
#   make site       -> the whole site into dist/
#   make serve      -> preview dist/ at http://localhost:8000
#   make check      -> assert each PDF is what we think it is before sending it
#   make deploy     -> build the site and push it to Cloudflare
#   make watch      -> rebuild the PDFs whenever a source changes
#   make clean

TPL_PDF  := template.typ
TPL_HTML := template.html

# Temporary landing-page state lives outside the copy. LOOKING_FOR_WORK can
# also be overridden for one build: make site LOOKING_FOR_WORK=false.
include site.conf

# Everything the pages built from Markdown share: the wrapper, the stylesheet,
# and the filter that sends links leaving the site to a new tab.
HTML_FLAGS := --template=$(TPL_HTML) --css=/assets/page.css \
              --lua-filter=filters/external-links.lua

DIST   := dist
PDF_EN := $(DIST)/Ilya-Mois-CV.pdf
PDF_RU := $(DIST)/Ilya-Mois-CV-ru.pdf

SRC_EN := src/cv.md
SRC_RU := src/cv.ru.md

# markdown-citations: without it "@tonconnect/sdk" is parsed as a citation
# and the build fails.
PANDOC := pandoc -f markdown-citations

# shift-heading-level-by: "## Summary" in the CV source becomes a level-1
# heading in the output, so the templates' rules line up with it. The projects
# page is written with ## already at the right level, so it is not shifted.
CV_FLAGS := --shift-heading-level-by=-1

.PHONY: all site serve check deploy watch clean

all: $(PDF_EN) $(PDF_RU)

$(DIST):
	mkdir -p $@

$(PDF_EN): $(SRC_EN) $(TPL_PDF) | $(DIST)
	$(PANDOC) $(SRC_EN) $(CV_FLAGS) --template=$(TPL_PDF) --pdf-engine=typst -o $@

$(PDF_RU): $(SRC_RU) $(TPL_PDF) | $(DIST)
	$(PANDOC) $(SRC_RU) $(CV_FLAGS) --template=$(TPL_PDF) --pdf-engine=typst -o $@

# dist/ is what gets deployed. Directory-style URLs (/cv, /cv/ru, /projects)
# rather than /cv.html, because they are what goes on paper and in an email.
site:
	@rm -rf $(DIST)
	@mkdir -p $(DIST)/assets $(DIST)/cv/ru $(DIST)/projects
	@$(MAKE) --no-print-directory $(PDF_EN) $(PDF_RU)
	@if [ "$(LOOKING_FOR_WORK)" = "true" ]; then \
		sed -e '/<!-- job-search:start -->/d' \
		    -e '/<!-- job-search:end -->/d' \
		    -e 's/@JOB_SEARCH_UPDATED@/$(JOB_SEARCH_UPDATED)/g' \
		    src/index.html > $(DIST)/index.html; \
	else \
		sed '/<!-- job-search:start -->/,/<!-- job-search:end -->/d' \
		    src/index.html > $(DIST)/index.html; \
	fi
	cp assets/*.css $(DIST)/assets/
	cp public/* $(DIST)/
	$(PANDOC) $(SRC_EN)      $(HTML_FLAGS) -o $(DIST)/cv/index.html
	$(PANDOC) $(SRC_RU)      $(HTML_FLAGS) -o $(DIST)/cv/ru/index.html
	$(PANDOC) src/projects.md $(HTML_FLAGS) -o $(DIST)/projects/index.html
	@echo "$(DIST)/ built — $$(find $(DIST) -type f | wc -l | tr -d ' ') files"

serve: site
	@echo "http://localhost:8000 — ctrl-c to stop"
	@cd dist && python3 -m http.server 8000

check: all
	@./check-pdf.sh $(PDF_EN) $(SRC_EN)
	@echo
	@./check-pdf.sh $(PDF_RU) $(SRC_RU)

deploy: site
	npx wrangler deploy

watch:
	@echo "watching sources and templates — ctrl-c to stop"
	@while true; do \
	  $(MAKE) --silent all; \
	  fswatch -1 $(SRC_EN) $(SRC_RU) $(TPL_PDF) >/dev/null 2>&1 || sleep 2; \
	done

clean:
	rm -rf $(DIST)
