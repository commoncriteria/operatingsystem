# Include if it exists (so people could do set their own settings
-include ~/commoncriteria/User.make
-include User.make
TRANS?=transforms

DIFF_TAGS?=4.2.1
#TMP?=/tmp

include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make

