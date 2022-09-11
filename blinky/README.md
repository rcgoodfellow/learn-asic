# Blinky

This project is derived from a nice
[Hello Arty tutorial](https://projectf.io/posts/hello-arty-1/) tutorial I found
online. It's good starting point to verify that

- The Vivado toolchain is installed and set up properly.
- The Arty A7 wire and board drivers are installed.
- Communication with the Arty board works.

## Board

Digilent Arty A7 100T.

## Workflow

```shell
./exec compile.tcl
./exec run.tcl
```

## Result

- Flipping switch 1 toggles LEDs 1 and 2.
- Flipping switch 2 toggles LEDs 3 and 4.
