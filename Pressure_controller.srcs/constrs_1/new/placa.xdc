##Switches
set_property -dict { PACKAGE_PIN V2   IOSTANDARD LVCMOS33 } [get_ports { data_i }]; #SW 3
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports { ready_i }]; #SW 2
set_property -dict { PACKAGE_PIN K1   IOSTANDARD LVCMOS33 } [get_ports { rst_n_i }]; #SW 1
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { clk_i }]; #SW 0
set_property -dict { PACKAGE_PIN U1   IOSTANDARD LVCMOS33 } [get_ports { test_i }]; #SW 0


##LEDs
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { led_0_o }]; #LED 0
set_property -dict { PACKAGE_PIN E5   IOSTANDARD LVCMOS33 } [get_ports { led_1_o }]; #LED 1
set_property -dict { PACKAGE_PIN E6   IOSTANDARD LVCMOS33 } [get_ports { led_2_o }]; #LED 2