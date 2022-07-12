# Makefile by Matheus Souza (github.com/mfbsouza)

# project name
PROJECT  := firmware

# paths
BUILDDIR := ./build
DBGDIR   := $(BUILDDIR)/debug
RELDIR   := $(BUILDDIR)/release
INCDIR   := ./include

# compiler and binutils
PREFIX := avr-
CC     := $(PREFIX)gcc
AS     := $(PREFIX)gcc
CXX    := $(PREFIX)g++
OD     := $(PREFIX)objdump

CP     := $(PREFIX)objcopy
HEX    := $(CP) -O ihex
BIN    := $(CP) -O binary

# flags
CFLAGS   := -Wall -I $(INCDIR) -MMD -MP
CXXLAGS  := -Wall -I $(INCDIR) -MMD -MP
LDFLAGS  :=

# board configuration
include ./arch/atmega328p/config.mk

ifeq ($(DEBUG),1)
	BINDIR    := $(DBGDIR)
	OBJDIR    := $(DBGDIR)/obj
	CFLAGS    += -g -O0 -DDEBUG
	CXXFLAGS  += -g -O0 -DDEBUG
else
	BINDIR    := $(RELDIR)
	OBJDIR    := $(RELDIR)/obj
	CFLAGS    += -g -Os
	CXXFLAGS  += -g -Os
endif

# sources to compile
ALLCSRCS   += $(shell find ./src ./include -type f -name *.c)
ALLCXXSRCS += $(shell find ./src ./include -type f -name *.cpp)

# set the linker to g++ if there is any c++ source code
ifeq ($(ALLCXXSRCS),)
	LD := $(PREFIX)gcc
else
	LD := $(PREFIX)g++
endif

# objects settings
COBJS   := $(addprefix $(OBJDIR)/, $(notdir $(ALLCSRCS:.c=.o)))
CXXOBJS := $(addprefix $(OBJDIR)/, $(notdir $(ALLCXXSRCS:.cpp=.o)))
ASMOBJS := $(addprefix $(OBJDIR)/, $(notdir $(ALLASMSRCS:.s=.o)))
OBJS    := $(COBJS) $(CXXOBJS) $(ASMOBJS)
DEPS    := $(OBJS:.o=.d)

# paths where to search for sources
SRCPATHS := $(sort $(dir $(ALLCSRCS)) $(dir $(ALLCXXSRCS)) $(dir $(ALLASMSRCS)))
VPATH     = $(SRCPATHS)

# output
OUTFILES := \
	$(BINDIR)/$(PROJECT).elf \
	$(BUILDDIR)/$(PROJECT).lst \
	$(BINDIR)/$(PROJECT).hex \
	$(BINDIR)/$(PROJECT).bin

# targets
.PHONY: all clean

all: $(OBJDIR) $(BINDIR) $(OBJS) $(OUTFILES)

# targets for the dirs
$(OBJDIR):
	@mkdir -p $(OBJDIR)

$(BINDIR):
	@mkdir -p $(BINDIR)

# target for c objects
$(COBJS) : $(OBJDIR)/%.o : %.c
ifeq ($(VERBOSE),1)
	$(CC) -c $(CFLAGS) $< -o $@
else
	@echo -n "[CC]\t$<\n"
	@$(CC) -c $(CFLAGS) $< -o $@
endif

# target for cpp objects
$(CXXOBJS) : $(OBJDIR)/%.o : %.cpp
ifeq ($(VERBOSE),1)
	$(CXX) -c $(CXXFLAGS) $< -o $@
else
	@echo -n "[CXX]\t$<\n"
	@$(CXX) -c $(CXXFLAGS) $< -o $@
endif

# target for asm objects
$(ASMOBJS) : $(OBJDIR)/%.o : %.s
ifeq ($(VERBOSE),1)
	$(AS) $(ASMFLAGS) $< -o $@
else
	@echo -n "[AS]\t$<\n"
	@$(AS) $(ASMFLAGS) $< -o $@
endif

# target for ELF file
$(BINDIR)/$(PROJECT).elf: $(OBJS)
ifeq ($(VERBOSE),1)
	$(LD) $(LDFLAGS) $(OBJS) -o $@
else
	@echo -n "[LD]\t./$@\n"
	@$(LD) $(LDFLAGS) $(OBJS) -o $@
endif

# target for disassembly and sections header info
$(BUILDDIR)/$(PROJECT).lst: $(BINDIR)/$(PROJECT).elf
ifeq ($(VERBOSE),1)
	$(OD) -h -S $< > $@
else
	@echo -n "[OD]\t./$@\n"
	@$(OD) -h -S $< > $@
endif

# target for binary firmware
%.hex: %.elf
ifeq ($(VERBOSE),1)
	$(HEX) $< $@
else
	@echo -n "[HEX]\t./$@\n"
	@$(HEX) $< $@
endif

%.bin: %.elf
ifeq ($(VERBOSE),1)
	$(BIN) $< $@
else
	@echo -n "[BIN]\t./$@\n"
	@$(BIN) $< $@
endif

# target for cleaning files
clean:
	rm -rf $(BUILDDIR)

# Include the dependency files, should be the last of the makefile
-include $(DEPS)
