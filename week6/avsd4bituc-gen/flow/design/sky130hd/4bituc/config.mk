export DESIGN_NICKNAME = 4bituc
export DESIGN_NAME = async4bituc

export PLATFORM    = sky130hd

export VERILOG_FILES 		= $(sort $(wildcard ./design/src/$(DESIGN_NICKNAME)/*.v)) 
			  	  #../blocks/$(PLATFORM)/AUC_blackbox.v
export SDC_FILE    		= ./design/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export DIE_AREA   	 	= 0 0 100 100
export CORE_AREA   		= 10 10 90 90

# area of the smaller voltage domain
#export VD1_AREA                 = 33.58 32.64 64.86 62.56

# power delivery network config file
export PDN_TCL 			= ../blocks/$(PLATFORM)/pdn.tcl

export ADDITIONAL_LEFS  	= ../blocks/$(PLATFORM)/lef/onebitADC.lef \
                        	  ../blocks/$(PLATFORM)/lef/RINGOSC.lef

export ADDITIONAL_GDS_FILES 	= ../blocks/$(PLATFORM)/gds/onebitADC.gds \
			      	  ../blocks/$(PLATFORM)/gds/RINGOSC.gds

# informs what cells should be placed in the smaller voltage domain
# export DOMAIN_INSTS_LIST 	= ../blocks/$(PLATFORM)/auc_domain_insts.txt

# configuration for placement

export MACRO_PLACE_HALO         = 1 1
export MACRO_PLACE_CHANNEL      = 30 30
export MACRO_PLACEMENT          = ../blocks/$(PLATFORM)/manual_macro.tcl


# don't run global place w/o IOs
#export HAS_IO_CONSTRAINTS = 1
# don't run non-random IO placement (step 3_2)
export PLACE_PINS_ARGS = -random

export GPL_ROUTABILITY_DRIVEN = 1

# DPO optimization currently fails on the tempsense
export ENABLE_DPO = 0

#export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 4
#export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2

# configuration for routing

# export PRE_GLOBAL_ROUTE = $(SCRIPTS_DIR)/openfasoc/pre_global_route.tcl

# informs any short circuits that should be forced during routing
 export CUSTOM_CONNECTION	= ../blocks/$(PLATFORM)/auc_custom_net.txt

# indicates with how many connections the VIN route from the HEADER cells connects to the VIN power ring
#export VIN_ROUTE_CONNECTION_POINTS = 1
