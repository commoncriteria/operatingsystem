TRANS?=transforms
# Include if it exists (so people could do set their own settings
-include LocalUser.make

DIFF_TAGS=v4.2
#TMP?=/tmp

include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make

