# config related to AVR ATmega 328p boards

CFLAGS   += -mmcu=atmega328p -DF_CPU=16000000UL
CXXFLAGS += -mmcu=atmega328p -DF_CPU=16000000UL
LDFLAGS  += -mmcu=atmega328p -Wl,-Map=$(BUILDDIR)/memory.map

# linker flags for no avr libc support

#ALLASMSRCS  += ./arch/atmega328p/vectors.s
#LDSCRIPT    += ./arch/atmega328p/lscript.ld
#ASMFLAGS    += -Wall -I $(INCDIR) $(ARCHCFLAGS) -MMD -MP
#ARCHLDFLAGS := -mmcu=atmega328p -nostdlib -nodefaultslibs -nostartfiles -T $(LDSCRIPT) -Wl,-Map=$(BUILDDIR)/memory.map

