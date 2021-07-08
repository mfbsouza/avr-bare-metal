TARGET = firmware

# MCU Settings
MCU := atmega328p
PROGRAMMER := arduino
PORT := /dev/ttyACM0

BUILD_DIR = build
BIN_DIR = bin
SRC_DIR = src

#SRCS = $(shell find $(SRC_DIR) -name *.c -or -name *.s)
#OBJS = $(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(SRCS:%=%.o))

OBJS = build/vectors.s.o \
	build/init.c.o \
	build/main.c.o

DEPS = $(OBJS:.o=.d)

CC = avr-gcc
CFLAGS = -std=c99 -Wall -O0 -mmcu=$(MCU) -MMD -MP
LDFLAGS = -nodefaultlibs -nostartfiles -T arch/$(MCU)/lscript.ld -Wl,-Map=memory.map

$(BIN_DIR)/$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# assembly code related to the MCU (vector table)
$(BUILD_DIR)/%.s.o: arch/$(MCU)/%.s
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR) memory.map

.PHONY: objcopy
objcopy:
	avr-objcopy -O ihex $(BIN_DIR)/$(TARGET) $(BIN_DIR)/$(TARGET).hex

.PHONY: flash
flash:
	avrdude -v -p $(MCU) -c $(PROGRAMMER) -P $(PORT) -U flash:w:$(BIN_DIR)/$(TARGET).hex

-include $(DEPS)
