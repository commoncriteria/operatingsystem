IN = input
OUT = output
TRANS = transforms
APP_XML=$(IN)/operatingsystem.xml
TABLE=$(OUT)/operatingsystem-table.html
SIMPLIFIED=$(OUT)/operatingsystem-table-reqs.html
APP_HTML=$(OUT)/operatingsystem.html
APP_OP_HTML=$(OUT)/operatingsystem-optionsappendix.html
APP_RELEASE_HTML=$(OUT)/operatingsystem-release.html
all: $(TABLE) $(SIMPLIFIED) $(APP_HTML)

pp:$(APP_HTML)
$(APP_HTML):  $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc -o $(APP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on -o $(APP_OP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(APP_RELEASE_HTML) $(TRANS)/pp2html.xsl $(APP_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(APP_XML)
	xsltproc  --stringparam release final -o $(TABLE) $(TRANS)/pp2table.xsl $(APP_XML)

simplified: $(SIMPLIFIED)
$(SIMPLIFIED): $(TRANS)/pp2simplified.xsl $(APP_XML)
	xsltproc --stringparam release final -o $(SIMPLIFIED) $(TRANS)/pp2simplified.xsl $(APP_XML)

schema/operatingsystem.rnc: schema/operatingsystem.rng
	trang -I rng -O rnc  schema/operatingsystem.rng schema/operatingsystem.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_RELEASE_HTML) $(APP_OP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
