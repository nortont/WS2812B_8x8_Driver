## This file is a general .xdc for the Zybo Z7 Rev. B
## It is compatible with the Zybo Z7-20 and Zybo Z7-10
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

##Clock signal
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports sys_clock]
create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports sys_clock]

##LEDs
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led_0 }]; #IO_L23P_T3_35 Sch=led[0]
#set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { led_1 }]; #IO_L23N_T3_35 Sch=led[1]


##Pmod Header JB (Zybo Z7-20 only)
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports led_data]
set_property -dict {PACKAGE_PIN W8 IOSTANDARD LVCMOS33} [get_ports clkOut1]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports clkOut2]
#set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33     } [get_ports { jb[3] }]; #IO_L11N_T1_SRCC_13 Sch=jb_n[2]
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33     } [get_ports { jb[4] }]; #IO_L13P_T2_MRCC_13 Sch=jb_p[3]
#set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33     } [get_ports { jb[5] }]; #IO_L13N_T2_MRCC_13 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33     } [get_ports { jb[6] }]; #IO_L22P_T3_13 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33     } [get_ports { jb[7] }]; #IO_L22N_T3_13 Sch=jb_n[4]

set_property IOSTANDARD LVCMOS33 [get_ports {data[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[0]}]
