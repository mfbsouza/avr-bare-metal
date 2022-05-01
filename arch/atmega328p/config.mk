# config related to AVR ATmega 328p boards

PREFIX      := avr-
ARCHCFLAGS  := -mmcu=atmega328p -DF_CPU=16000000UL
ARCHLDFLAGS := -mmcu=atmega328p -Wl,-Map=$(BUILDDIR)/memory.map
#ARCHLDFLAGS := -mmcu=atmega328p -nostdlib -nodefaultslibs -nostartfiles -T $(LDSCRIPT) -Wl,-Map=$(BUILDDIR)/memory.map

