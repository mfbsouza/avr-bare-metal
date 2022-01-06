# config related to AVR ATtiny 85 boards

PREFIX      := avr-
ARCHCFLAGS  := -mmcu=attiny85
ARCHLDFLAGS := -mmcu=attiny85 -Wl,-Map=$(BUILDDIR)/memory.map

# Shared variable

ALLCFLAGS += \
	$(ARCHCFLAGS)

ALLLDFLAGS += \
	$(ARCHLDFLAGS)
