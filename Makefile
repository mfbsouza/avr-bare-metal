# Makefile by Matheus Souza (github.com/mfbsouza)

# project name

PROJECT  := firmware

# paths

BUILDDIR := ./build
DBGDIR   := $(BUILDDIR)/debug
RELDIR   := $(BUILDDIR)/release
INCDIR   := ./include

# board configuration if there is any (used in firmware programming)

include ./arch/atmega328p/config.mk

# compiler settings

CC  := $(PREFIX)gcc
AS  := $(PREFIX)gcc
LD  := $(PREFIX)gcc
CP  := $(PREFIX)objcopy
OD  := $(PREFIX)objdump
HEX := $(CP) -O ihex
BIN := $(CP) -O binary

ifeq ($(DEBUG),1)
	BINDIR    := $(DBGDIR)
	OBJDIR    := $(DBGDIR)/obj
	ALLCFLAGS += -g -O0 -DDEBUG
else
	BINDIR    := $(RELDIR)
	OBJDIR    := $(RELDIR)/obj
	ALLCFLAGS += -g -O3
endif

# final compilation flags

CFLAGS   := -std=c99 -Wall $(ALLCFLAGS) -MMD -MP
LDFLAGS  := $(ALLLDFLAGS)

# sources to compile

ALLCSRCS   += $(shell find ./src ./include -type f -name *.c)
ALLASMSRCS += $(shell find ./src ./include -type f -name *.s)

# sources settings

CSRCS    := $(ALLCSRCS)
ASMSRCS  := $(ALLASMSRCS)
SRCPATHS := $(sort $(dir $(CSRCS)) $(dir $(ASMSRCS)))

# objects settings

COBJS   := $(addprefix $(OBJDIR)/, $(notdir $(CSRCS:.c=.o)))
ASMOBJS := $(addprefix $(OBJDIR)/, $(notdir $(ASMOBJS:.s=.o)))
OBJS    := $(COBJS) $(ASMOBJS)
DEPS    := $(OBJS:.o=.d)

# paths where to search for sources

VPATH   = $(SRCPATHS)

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
	$(CC) -c $(CFLAGS) -I $(INCDIR) $< -o $@
else
	@echo -e "[CC]\t$<"
	@$(CC) -c $(CFLAGS) -I $(INCDIR) $< -o $@
endif

# target for asm objects

$(ASMOBJS) : $(OBJDIR)/%.o : %.s
ifeq ($(VERBOSE),1)
	$(AS) -c $(CFLAGS) $< -o $@
else
	@echo -e "[AS]\t$<"
	@$(AS) -c $(CFLAGS) $< -o $@
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

include ./arch/target.mk

clean:
	rm -rf $(BUILDDIR)

# Include the dependency files, should be the last of the makefile

-include $(DEPS)
