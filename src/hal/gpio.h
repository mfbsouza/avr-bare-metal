#ifndef __GPIO_H__
#define __GPIO_H__

#include <avr/io.h>
#include "common/bitmask.h"

#define PB_FLAG 0x10 << 0
#define PC_FLAG 0x10 << 1
#define PD_FLAG 0x10 << 2

enum gpio_mode {
	OUTPUT,
	INPUT,
	INPUT_PULLUP
};

enum gpio_port {
	GPIO_PB0 = 0x0 | PB_FLAG,
	GPIO_PB1 = 0x1 | PB_FLAG,
	GPIO_PB2 = 0x2 | PB_FLAG,
	GPIO_PB3 = 0x3 | PB_FLAG,
	GPIO_PB4 = 0x4 | PB_FLAG,
	GPIO_PB5 = 0x5 | PB_FLAG,
	GPIO_PB6 = 0x6 | PB_FLAG,
	GPIO_PC0 = 0x0 | PC_FLAG,
	GPIO_PC1 = 0x1 | PC_FLAG,
	GPIO_PC2 = 0x2 | PC_FLAG,
	GPIO_PC3 = 0x3 | PC_FLAG,
	GPIO_PC4 = 0x4 | PC_FLAG,
	GPIO_PC5 = 0x5 | PC_FLAG,
	GPIO_PC6 = 0x6 | PC_FLAG,
	GPIO_PD0 = 0x0 | PD_FLAG,
	GPIO_PD1 = 0x1 | PD_FLAG,
	GPIO_PD2 = 0x2 | PD_FLAG,
	GPIO_PD3 = 0x3 | PD_FLAG,
	GPIO_PD4 = 0x4 | PD_FLAG,
	GPIO_PD5 = 0x5 | PD_FLAG,
	GPIO_PD6 = 0x6 | PD_FLAG
};

enum gpio_value {
	GPIO_LOW,
	GPIO_HIGH
};

/* functions */

void gpio_init(enum gpio_port, enum gpio_mode);
void gpio_write(enum gpio_port, enum gpio_value);
void gpio_flip(enum gpio_port);
char gpio_read(enum gpio_port);

#endif /*__GPIO_H__*/
