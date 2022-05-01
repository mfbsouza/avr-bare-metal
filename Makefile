# Makefile by Matheus Souza (github.com/mfbsouza)

# project name
PROJECT  := firmware

# paths
BUILDDIR := ./build
DBGDIR   := $(BUILDDIR)/debug
RELDIR   := $(BUILDDIR)/release
INCDIR   := ./src

# board configuration if there is any (used in firmware programming)
include ./arch/atmega328p/config.mk

# compiler
CC  := $(PREFIX)gcc
AS  := $(PREFIX)gcc
CXX := $(PREFIX)g++
LD  := $(PREFIX)gcc
OD  := $(PREFIX)objdump

CP  := $(PREFIX)objcopy
HEX := $(CP) -O ihex
BIN := $(CP) -O binary

# flags
CFLAGS   := -std=c99 -Wall -I $(INCDIR) $(ARCHCFLAGS) -MMD -MP
CXXLAGS  := -Wall -I $(INCDIR) $(ARCHCFLAGS) -MMD -MP
ASMFLAGS := -Wall -I $(INCDIR) $(ARCHCFLAGS) -MMD -MP
LDFLAGS  := $(ARCHLDFLAGS)

ifeq ($(DEBUG),1)
	BINDIR    := $(DBGDIR)
	OBJDIR    := $(DBGDIR)/obj
	CFLAGS    += -g -O0 -DDEBUG
	CXXFLAGS  += -g -O0 -DDEBUG
else
	BINDIR    := $(RELDIR)
	OBJDIR    := $(RELDIR)/obj
	CFLAGS    += -g -O3
	CXXFLAGS  += -g -O3
endif

# sources to compile
ALLCSRCS   += $(shell find ./src -type f -name *.c)
ALLCXXSRCS += $(shell find ./src -type f -name *.cpp)
ALLASMSRCS += $(shell find ./src -type f -name *.s)

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


$(OBJDIR):
	@mkdir -p $(OBJDIR)

$(BINDIR):
	@mkdir -p $(BINDIR)

# target for c objects
$(COBJS) : $(OBJDIR)/%.o : %.c
ifeq ($(VERBOSE),1)
	$(CC) -c $(CFLAGS) $< -o $@
else
	@echo -e "[CC]\t$<"
	@$(CC) -c $(CFLAGS) $< -o $@
endif

# target for cpp objects
$(CXXOBJS) : $(OBJDIR)/%.o : %.cpp
ifeq ($(VERBOSE),1)
	$(CXX) -c $(CXXFLAGS) $< -o $@
else
	@echo -e "[CXX]\t$<"
	@$(CXX) -c $(CXXFLAGS) $< -o $@
endif

# target for asm objects
$(ASMOBJS) : $(OBJDIR)/%.o : %.s
ifeq ($(VERBOSE),1)
	$(AS) $(ASMFLAGS) $< -o $@
else
	@echo -e "[AS]\t$<"
	@$(AS) $(ASMFLAGS) $< -o $@
endif

# target for ELF file
$(BINDIR)/$(PROJECT).elf: $(OBJS)
ifeq ($(VERBOSE),1)
	$(LD) $(LDFLAGS) $(OBJS) -o $@
else
	@echo -e "[LD]\t./$@"
	@$(LD) $(LDFLAGS) $(OBJS) -o $@
endif

# target for disassembly and sections header info
$(BUILDDIR)/$(PROJECT).lst: $(BINDIR)/$(PROJECT).elf
ifeq ($(VERBOSE),1)
	$(OD) -h -S $< > $@
else
	@echo -e "[OD]\t./$@"
	@$(OD) -h -S $< > $@
endif

# target for architecture if there is any (used in firmware programming)
%.hex: %.elf
ifeq ($(VERBOSE),1)
	$(HEX) $< $@
else
	@echo -e "[HEX]\t./$@"
	@$(HEX) $< $@
endif

%.bin: %.elf
ifeq ($(VERBOSE),1)
	$(BIN) $< $@
else
	@echo -e "[BIN]\t./$@"
	@$(BIN) $< $@
endif

clean:
	rm -rf $(BUILDDIR)

# Include the dependency files, should be the last of the makefile
-include $(DEPS)
