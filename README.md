# AVR "Bare Metal" Programming
A getting started with bare-metal programming on a AVR microcontroller using the GNU Toolchain to learning purposes

## Sections

- [prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Contributing](#contributing)

## Prerequisites

install the toolchain:
- avr-gcc
- avr-binutils
- make
- avrdude

## Quick Start

### 1. Get the files

    git clone https://github.com/mfbsouza/avr-bare-metal.git

### 2. Write your code

write your code in `main.c` and create how many source files you want and compile it with:

    make

### 3. (Optional) Analyse it

take a look at the `build/memory.map` and `build/firmware.lst` files to check if everything is in other as expected.

### 4. Flash it

Plug yout AVR Microcontroller with a bootloader and just:

    ./scripts/flash.sh -P <port> -m <mcu> -c <programmer> -b <path_to_hex>

Ex:.

    ./scripts/flash.sh -P /dev/ttyACM0 -m atmega328p -c arduino -b build/release/firmware.hex

## Contributing

Please feel free to contribute to this project in anyway you may want (issues, pull request, ideas...). There is no template and anything will be welcome.
