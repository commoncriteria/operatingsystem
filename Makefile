TRANS?=transforms
# Include if it exists (so people could do set their own settings
-include User.make

DIFF_TAGS=4.2.1 v4.2.2-draft-bob
#TMP?=/tmp

include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make

