export DESIGN_NICKNAME = imc
export DESIGN_NAME = imc

export PLATFORM    = sky130hd

export VERILOG_FILES 		= $(sort $(wildcard ./design/src/$(DESIGN_NICKNAME)/*.v)) 
			  	  #../blocks/$(PLATFORM)/AUC_blackbox.v
export SDC_FILE    		= ./design/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export DIE_AREA   	 	= 0 0 150 150
export CORE_AREA   		= 30 30 120 120

# area of the smaller voltage domain
#export VD1_AREA                 = 33.58 32.64 64.86 62.56

# power delivery network config file
export PDN_TCL 			= ../blocks/$(PLATFORM)/pdn.tcl

export ADDITIONAL_LEFS  	= ../blocks/$(PLATFORM)/lef/SRAMLOGIC.lef \

export ADDITIONAL_GDS_FILES 	= ../blocks/$(PLATFORM)/gds/SRAMLOGIC.gds \

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

# informs any short circuits that should be forced during routing
# export CUSTOM_CONNECTION	= ../blocks/$(PLATFORM)/auc_custom_net.txt


#routing of power lines to macros - why the power lines are being treated differently than other I/O pins
export PRE_GLOBAL_ROUTE  = $(SCRIPTS_DIR)/openfasoc/pre_global_route.tcl

#the power and ground lines are routed as custom connections, which is provided to pre_global_route.tcl

export VSS_CONNECTION = ../blocks/$(PLATFORM)/VSS_connection.txt

export VDD_CONNECTION = ../blocks/$(PLATFORM)/VDD_connection.txt

# indicates with how many connections the VIN route from the HEADER cells connects to the VIN power ring

# indicates how many custom connections are needed - we need VDD and GND connectin to our macro. The custom connections are defined in pre_global_route.tcl

export VIN_CONNECTION_POINTS = 2
