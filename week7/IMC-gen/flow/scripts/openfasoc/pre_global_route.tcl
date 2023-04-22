# Create VDD and GND nets
source $::env(SCRIPTS_DIR)/openfasoc/create_routable_power_net.tcl
create_routable_power_net "VSS" $::env(VIN_CONNECTION_POINTS)
create_routable_power_net "VDD" $::env(VIN_CONNECTION_POINTS)
# NDR rules
#
source $::env(SCRIPTS_DIR)/openfasoc/add_ndr_rules.tcl

# Custom connections
source $::env(SCRIPTS_DIR)/openfasoc/create_custom_connections.tcl
if {[info exist ::env(GND_connection)]} {
  create_custom_connections $::env(VSS_CONNECTION)
}
if {[info exist ::env(VDD_connection)]} {
  create_custom_connections $::env(VDD_CONNECTION)
}
