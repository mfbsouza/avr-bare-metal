# AVR "Bare Metal" Programming
A getting started with bare-metal programming on a AVR microcontroller using the GNU Toolchain to learning purposes

## Sections

- [prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Contributing](#contributing)

## Prerequisites

install the toolchain:
- avr-gcc `(GNU C compiler for AVR)`
- avr-binutils  `(GNU set of programs to assemble and manipulate binary and object files for the AVR architecture)`
- make `(GNU Make for building the project files)`
- avrdude `(manipulate the ROM and EEPROM contents of AVR microcontrollers)`

## Quick Start

### 1. Get the files

    git clone https://github.com/mfbsouza/avr-bare-metal.git

### 2. Write your code

write your code in `main.c` and create how many source files you want and compile it with:

    make

If creating new source files don't forget to add their objects to the `OBJS` variable in the makefile

### 3. (Optional) Analyse it

check the `memory.map` file to check if everything is in other as expected, you can also do the following command to check the final section headers:

    avr-objdump -h bin/firmware

And diassembly the firmware with:

    avr-objdumb -S bin/firmware

### 4. Convert ELF to HEX (objcopy)

After the make command the fimware will be in the ELF format, to convert it to intel hex just do:

    make objcopy

### 5. Flash it

Plug yout AVR Microcontroller with a bootloader and just:

    make flash PORT=/dev/ttyACM0

change `/dev/ttyUSB0` for the right port in your PC

## Contributing

Please feel free to contribute to this project in anyway you may want (issues, pull request, ideas...). There is no template and anything will be welcome.
