TRANS?=transforms
# Include if it exists (so people could do set their own settings
-include LocalUser.make

# osdefault: default 
#	python3 $(TRANS)/python/pp-to-worksheet.py input/operatingsystem.xml > output/OsWorksheet.htm

include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make
