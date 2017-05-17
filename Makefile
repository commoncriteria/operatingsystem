TRANS?=transforms
# Include if it exists (so people could do set their own settings
-include LocalUser.make

include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make
