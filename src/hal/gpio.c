#include "gpio.h"

void gpio_init(enum gpio_port port, enum gpio_mode mode)
{
	if (mode == OUTPUT) {
		// DDxn must be high
		if ((port & PB_FLAG) == PB_FLAG) {
			BIT_SET(DDRB, (port & 0x0F));
		}
		else if ((port & PC_FLAG) == PC_FLAG) {
			BIT_SET(DDRC, (port & 0x0F));
		}
		else if ((port & PD_FLAG) == PD_FLAG) {
			BIT_SET(DDRD, (port & 0x0F));
		}
	}
	else if (mode == INPUT || mode == INPUT_PULLUP) {
		// DDxn must be low and PORTxn must be high for pullup
		if ((port & PB_FLAG) == PB_FLAG) {
			BIT_CLR(DDRB, (port & 0x0F));
			if (mode == INPUT_PULLUP) BIT_SET(PORTB, (port & 0x0F));
		}
		else if ((port & PC_FLAG) == PC_FLAG) {
			BIT_CLR(DDRC, (port & 0x0F));
			if (mode == INPUT_PULLUP) BIT_SET(PORTC, (port & 0x0F));
		}
		else if ((port & PD_FLAG) == PD_FLAG) {
			BIT_CLR(DDRD, (port & 0x0F));
			if (mode == INPUT_PULLUP) BIT_SET(PORTD, (port & 0x0F));
		}
	}
}

void gpio_write(enum gpio_port port, enum gpio_value value)
{
	if ((port & PB_FLAG) == PB_FLAG) {
		if (value == GPIO_HIGH) BIT_SET(PORTB, (port & 0x0F));
		else BIT_CLR(PORTB, (port & 0x0F));
	}
	else if ((port & PC_FLAG) == PC_FLAG) {
		if (value == GPIO_HIGH) BIT_SET(PORTB, (port & 0x0F));
		else BIT_CLR(PORTC, (port & 0x0F));
	}
	else if ((port & PD_FLAG) == PD_FLAG) {
		if (value == GPIO_HIGH) BIT_SET(PORTB, (port & 0x0F));
		else BIT_CLR(PORTD, (port & 0x0F));
	}
}

char gpio_read(enum gpio_port port)
{
	if ((port & PB_FLAG) == PB_FLAG) {
		return (char) ((PINB >> (port & 0x0F)) & 0x01);
	}
	else if ((port & PC_FLAG) == PC_FLAG) {
		return (char) ((PINC >> (port & 0x0F)) & 0x01);
	}
	else if ((port & PD_FLAG) == PD_FLAG) {
		return (char) ((PIND >> (port & 0x0F)) & 0x01);
	}
	return -1;
}

void gpio_flip(enum gpio_port port)
{
	if ((port & PB_FLAG) == PB_FLAG) {
		BIT_FLIP(PORTB, (port & 0x0F));
	}
	else if ((port & PC_FLAG) == PC_FLAG) {
		BIT_FLIP(PORTC, (port & 0x0F));
	}
	else if ((port & PD_FLAG) == PD_FLAG) {
		BIT_FLIP(PORTD, (port & 0x0F));
	}
}
