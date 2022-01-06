# config related to AVR ATmega 328p boards

PREFIX      := avr-
ARCHCFLAGS  := -mmcu=atmega328p
ARCHLDFLAGS := -mmcu=atmega328p -Wl,-Map=$(BUILDDIR)/memory.map
#ARCHLDFLAGS := -mmcu=atmega328p -nostdlib -nodefaultslibs -nostartfiles -T $(LDSCRIPT) -Wl,-Map=$(BUILDDIR)/memory.map

# Shared variable

ALLCFLAGS += \
	$(ARCHCFLAGS)

ALLLDFLAGS += \
	$(ARCHLDFLAGS)
