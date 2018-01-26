TRANS?=transforms
# Include if it exists (so people could do set their own settings
-include LocalUser.make


include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make

worksheet:
	python3 $(TRANS)/python/pp-to-worksheet.py $(PP_XML):$(OUT)/OsWorksheet.html
