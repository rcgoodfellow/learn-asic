###############################################################################
# This script will read in the system verilog sources in ./src and perform
# synthesis using Vivado.
#
# usage: ./exec compile.tcl
#
# assumptions:
#   - Digilent Arty A7 100T board.
#
# inputs:
#   - src/*.sv
#   - src/arty_a7_100t.xdc
#
# outputs:
#   reports:
#       - clock_util.rpt
#       - drc.rpt
#       - power_post_route.rpt
#       - power_post_synth.rpt
#       - timing_post_place.rpt
#       - timing_post_route_detail.rpt
#       - timing_post_route.rpt
#       - timing_post_synth.rpt
#       - util.rpt
#   bitstream:
#       - $module.bit
#   code:
#       - $module_impl_netlist.v
#       - $module_impl.xdc
#   checkpoints:
#       - post_place.dcp
#       - post_route.dcp
#       - post_synth.dcp
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

set outputDir ./out
file mkdir $outputDir

#------------------------------------------------------------------------------
# 1. Read source
#------------------------------------------------------------------------------

read_verilog [ glob ./src/*.sv ]
read_xdc ./src/arty_a7_100t.xdc

#------------------------------------------------------------------------------
# 2. Run synthesis
#
# part name is from https://bit.ly/arty-a7-part-number
#------------------------------------------------------------------------------

synth_design -top $module -part xc7a100tcsg324-1
write_checkpoint -force $outputDir/post_synth
report_timing_summary -file $outputDir/timing_post_synth.rpt
report_power -file $outputDir/power_post_synth.rpt

#------------------------------------------------------------------------------
# 3. Run placement and logic optimization
#------------------------------------------------------------------------------
opt_design
place_design
phys_opt_design
write_checkpoint -force $outputDir/post_place
report_timing_summary -file $outputDir/timing_post_place.rpt

#------------------------------------------------------------------------------
# 4. Run router
#------------------------------------------------------------------------------
route_design
write_checkpoint -force $outputDir/post_route
report_timing_summary -file $outputDir/timing_post_route.rpt
report_timing \
    -sort_by group \
    -max_paths 100 \
    -path_type summary \
    -file $outputDir/timing_post_route_detail.rpt
report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/util.rpt
report_power -file $outputDir/power_post_route.rpt
report_drc -file $outputDir/drc.rpt
write_verilog -force $outputDir/${module}_impl_netlist.v
write_xdc -no_fixed_only -force $outputDir/${module}_impl.xdc

#------------------------------------------------------------------------------
# 5. Generate Bitstream
#------------------------------------------------------------------------------
write_bitstream -force $outputDir/$module.bit
