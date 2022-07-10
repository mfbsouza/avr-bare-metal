# config related to AVR ATtiny 85 boards

CFLAGS   += -mmcu=attiny85
CXXFLAGS += -mmcu=attiny85
LDFLAGS  += -mmcu=attiny85 -Wl,-Map=$(BUILDDIR)/memory.map
