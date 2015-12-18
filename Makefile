IN = input
OUT = output
# You can easily build with another set of transforms (ie the developer ones) by running
#    make <target> TRANS=/path/to/transforms
TRANS ?= transforms
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
	bash -c "hunspell -l -H -p <(cat $(TRANS)/dictionaries/*.txt OsDictionary.txt) output/*.html | sort -u"

spellcheck-esr: $(ESR_HTML)
	bash -c "hunspell -l -H -p <(cat $(TRANS)/dictionaries/*.txt OsDictionary.txt) $(ESR_HTML) | sort -u"	

spellcheck-os:  $(PP_HTML)
	bash -c "hunspell -l -H -p <(cat $(TRANS)/dictionaries/*.txt OsDictionary.txt) $(PP_HTML) | sort -u"

linkcheck: $(TABLE) $(SIMPLIFIED) $(PP_HTML) $(ESR_HTML) $(PP_OP_HTML) $(PP_RELEASE_HTML)
	for bb in output/*.html; do for aa in $$(\
	  sed "s/href=['\"]/\nhref=\"/g" $$bb | grep "^href=[\"']#" | sed "s/href=[\"']#//g" | sed "s/[\"'].*//g"\
        ); do grep "id=[\"']$${aa}[\"']" -q  $$bb || echo "Detected missing link $$bb:$$aa"; done; done


pp:$(PP_HTML)
$(PP_HTML):  $(TRANS)/pp2html.xsl $(TRANS)/ppcommons.xsl $(PP_XML)
	xsltproc -o $(PP_HTML) $(TRANS)/pp2html.xsl $(PP_XML)
	xsltproc --stringparam appendicize on -o $(PP_OP_HTML) $(TRANS)/pp2html.xsl $(PP_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(PP_RELEASE_HTML) $(TRANS)/pp2html.xsl $(PP_XML)

esr:$(ESR_HTML)
$(ESR_HTML):  $(TRANS)/esr2html.xsl $(TRANS)/ppcommons.xsl $(ESR_XML)
	xsltproc -o $(ESR_HTML) $(TRANS)/esr2html.xsl $(ESR_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(PP_XML)
	xsltproc  --stringparam release final -o $(TABLE) $(TRANS)/pp2table.xsl $(PP_XML)

simplified: $(SIMPLIFIED)
$(SIMPLIFIED): $(TRANS)/pp2simplified.xsl $(PP_XML)
	xsltproc --stringparam release final -o $(SIMPLIFIED) $(TRANS)/pp2simplified.xsl $(PP_XML)

rnc: $(TRANS)/schemas/schema.rnc
$(TRANS)/schemas/schema.rnc: $(TRANS)/schemas/schema.rng
	trang -I rng -O rnc  $(TRANS)/schemas/schema.rng $(TRANS)/schemas/schema.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(PP_HTML) $(PP_RELEASE_HTML) $(PP_OP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
