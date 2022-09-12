# Learn ASIC

This is a collection of projects I'm putting together to learn ASIC design using
FPGAs.

I come from a software development background with an editor + CLI tools
workflow. The projects here are put together using that type of workflow. I am
using Xilinx FPGAs for the moment, so
[Vivado](https://www.xilinx.com/support/download.html) is required to compile
and load these projects onto a development board. The free version of Vivado is
sufficient for all the examples here.

The top level [exec](exec), [compile.tcl](compile.tcl) and [run.tcl](run.tcl)
scripts are linked into each project directory and can be used to compile and
load each project without ever needing to use the Vivado GUI. The `exec` wrapper
simply provides colored output for warnings and errors and ensures a `1` exit
code is returned if an error is encountered. The basic workflow looks like this.

```shell
export MODULE=blinky
# edit code ...
./exec compile.tcl
./exec run.tcl
# repeat ...
```

## Project Overview

Projects are listed below in approximately increasing order of complexity.

- [Blinky](blinky) - A very simple program mostly to demonstrate the workflow
  and verify a development machine is set up properly.

- [Morse](morse) - The first ASIC project. A simple ISA and processor for
  executing [Morse code](https://en.wikipedia.org/wiki/Morse_code) programs.

## Vivado Setup

I'm running Vivado on Linux. In addition to the base install, here is what I
needed to do to get things working for the full workflow.

- [Install cable drivers](https://docs.xilinx.com/r/en-US/ug973-vivado-release-notes-install-license/Install-Cable-Drivers)
- [Install board files, Digilent example](https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-vitis#install_digilent_s_board_files)
