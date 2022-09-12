# Morse

A simple ISA and processor for 
[Morse code](https://en.wikipedia.org/wiki/Morse_code) programs.

## Board

Digilent Arty A7 100T.

## Workflow

```shell
export MODULE=morse
./exec compile.tcl
./exec run.tcl
```

## Instruction Set

The ISA for the Morse processor has 4 instructions.

```
dit
dah
space
speed <u6>
```

All instructions are 8 bits wide and have the following binary representations.

|Instruction|Binary|
|-------|------------|
| space | `00000000` |
| dit   | `10000000` |
| dah   | `01000000` |
| speed | `11SSSSSS` |

The `speed` instruction is the only one with a parameter. A 6-bit number that
indicates how many milliseconds a `dit` sustains for. If no value is set, 50 is
the default. The duration of a `dah` is three times that of a dit`. A `space` is
one `dit` in duration.

## System Design

This is an entirely serial/blocking design. Instructions are currently hard
coded into memory.

TODO:
- Loadable instructions
- Modular decoder, ditter, daher, spaceer elements.

## Result

Execution of a Morse code instruction set program via a blinking LED.
