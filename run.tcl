###############################################################################
# This script will load a compiled program onto the first target found in the
# get_hw_targets list.
#
# usage: ./exec run.tcl
#
# assumptions:
#   - Using first hardware target found
#
# inputs:
#   - out/top.bit
#
# outputs:
#   - bitstream has been loaded onto device
#
# reference for commands used: 
#   - https://bit.ly/xilinx-non-proj-tcl
###############################################################################

if { [info exists ::env(MODULE) ] } {
    set module $::env(MODULE)
} else {
    puts "must set environment variable MODULE"
    exit 1
}

open_hw_manager
connect_hw_server
current_hw_target [current_hw_target [lindex [get_hw_targets] 0]]
set_property PROGRAM.FILE ./out/$module.bit [current_hw_device]
open_hw_target
program_hw_devices
