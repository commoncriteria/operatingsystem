IN = input
OUT = output
TRANS = transforms
PP_XML=$(IN)/operatingsystem.xml
ESR_XML=$(IN)/esr.xml
TABLE=$(OUT)/operatingsystem-table.html
SIMPLIFIED=$(OUT)/operatingsystem-table-reqs.html
PP_HTML=$(OUT)/operatingsystem.html
ESR_HTML=$(OUT)/operatingsystem-esr.html
PP_OP_HTML=$(OUT)/operatingsystem-optionsappendix.html
PP_RELEASE_HTML=$(OUT)/operatingsystem-release.html
all: $(TABLE) $(SIMPLIFIED) $(PP_HTML) $(ESR_HTML)


spellcheck: $(ESR_HTML) $(PP_HTML)
	bash -c "hunspell -l -H -p <(cat validators/dictionary/*) output/*.html | sort -u"

spellcheck-esr: $(ESR_HTML)
	hunspell -l -H -p validators/Dictionary.txt $(ESR_HTML)	

spellcheck-os:  $(PP_HTML)
	hunspell -l -H -p validators/Dictionary.txt $(PP_HTML)


pp:$(PP_HTML)
$(PP_HTML):  $(TRANS)/pp2html.xsl $(PP_XML)
	xsltproc -o $(PP_HTML) $(TRANS)/pp2html.xsl $(PP_XML)
	xsltproc --stringparam appendicize on -o $(PP_OP_HTML) $(TRANS)/pp2html.xsl $(PP_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(PP_RELEASE_HTML) $(TRANS)/pp2html.xsl $(PP_XML)

esr:$(ESR_HTML)
$(ESR_HTML):  $(TRANS)/esr2html.xsl $(ESR_XML)
	xsltproc -o $(ESR_HTML) $(TRANS)/esr2html.xsl $(ESR_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(PP_XML)
	xsltproc  --stringparam release final -o $(TABLE) $(TRANS)/pp2table.xsl $(PP_XML)

simplified: $(SIMPLIFIED)
$(SIMPLIFIED): $(TRANS)/pp2simplified.xsl $(PP_XML)
	xsltproc --stringparam release final -o $(SIMPLIFIED) $(TRANS)/pp2simplified.xsl $(PP_XML)

validators/operatingsystem.rnc: validators/operatingsystem.rng
	trang -I rng -O rnc  validators/operatingsystem.rng validators/operatingsystem.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(PP_HTML) $(PP_RELEASE_HTML) $(PP_OP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
