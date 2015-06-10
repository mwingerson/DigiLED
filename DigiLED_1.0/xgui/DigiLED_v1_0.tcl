
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/DigiLED_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set COLOR_MODE [ipgui::add_param $IPINST -name "COLOR_MODE" -parent ${Page_0}]
  set_property tooltip {Red-Green-Blue or Hue-Saturation-Value} ${COLOR_MODE}
  ipgui::add_param $IPINST -name "NUMBER_OF_LEDS" -parent ${Page_0}
  set REFRESH_DELAY [ipgui::add_param $IPINST -name "REFRESH_DELAY" -parent ${Page_0}]
  set_property tooltip {delay between refreshing LEDs} ${REFRESH_DELAY}
  set C_S00_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of S_AXI address bus} ${C_S00_AXI_ADDR_WIDTH}


}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.NUMBER_OF_LEDS } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
	
	set C_S00_AXI_ADDR_WIDTH ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
	set NUMBER_OF_LEDS ${PARAM_VALUE.NUMBER_OF_LEDS}
	set values(NUMBER_OF_LEDS) [get_property value $NUMBER_OF_LEDS]
	set_property value [gen_USERPARAMETER_C_S00_AXI_ADDR_WIDTH_VALUE $values(NUMBER_OF_LEDS)] $C_S00_AXI_ADDR_WIDTH
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.COLOR_MODE { PARAM_VALUE.COLOR_MODE } {
	# Procedure called to update COLOR_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR_MODE { PARAM_VALUE.COLOR_MODE } {
	# Procedure called to validate COLOR_MODE
	return true
}

proc update_PARAM_VALUE.NUMBER_OF_LEDS { PARAM_VALUE.NUMBER_OF_LEDS } {
	# Procedure called to update NUMBER_OF_LEDS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUMBER_OF_LEDS { PARAM_VALUE.NUMBER_OF_LEDS } {
	# Procedure called to validate NUMBER_OF_LEDS
	return true
}

proc update_PARAM_VALUE.REFRESH_DELAY { PARAM_VALUE.REFRESH_DELAY } {
	# Procedure called to update REFRESH_DELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REFRESH_DELAY { PARAM_VALUE.REFRESH_DELAY } {
	# Procedure called to validate REFRESH_DELAY
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.NUMBER_OF_LEDS { MODELPARAM_VALUE.NUMBER_OF_LEDS PARAM_VALUE.NUMBER_OF_LEDS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUMBER_OF_LEDS}] ${MODELPARAM_VALUE.NUMBER_OF_LEDS}
}

proc update_MODELPARAM_VALUE.REFRESH_DELAY { MODELPARAM_VALUE.REFRESH_DELAY PARAM_VALUE.REFRESH_DELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REFRESH_DELAY}] ${MODELPARAM_VALUE.REFRESH_DELAY}
}

proc update_MODELPARAM_VALUE.COLOR_MODE { MODELPARAM_VALUE.COLOR_MODE PARAM_VALUE.COLOR_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR_MODE}] ${MODELPARAM_VALUE.COLOR_MODE}
}

