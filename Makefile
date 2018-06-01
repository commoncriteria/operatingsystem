TRANS?=transforms
# Include if it exists (so people could do set their own settings
-include LocalUser.make
PREV_RELEASE_PP_URL?=https://niap-ccevs.org/MMO/PP/-400-/

include $(TRANS)/ConfigAnnex.make

include $(TRANS)/Helper.make

