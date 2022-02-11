# Include if it exists (so people could do set their own settings
-include ~/commoncriteria/User.make
-include User.make
TRANS?=transforms
DIFF_USER_MAKE=User.make
#DIFF_TAGS?=4.2.1
DIFF_TAGS=release-4.2.1

include $(TRANS)/ConfigAnnex.make
include $(TRANS)/Helper.make



