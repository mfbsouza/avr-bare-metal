#include "hal/gpio.h"
#include "hal/uart.h"
#include <util/delay.h>

void on_rx();

int main ()
{
	gpio_init(GPIO_PB5, OUTPUT);
	
	const char *string = "hello uart!\r\nworking nicely!\r\ntry typing: ";

	uart_init(9600);
	uart_rx_callback(on_rx);
	uart_write(string, strlen(string));

	while(1) {
		gpio_write(GPIO_PB5, !gpio_read(GPIO_PB5));
		_delay_ms(250);
	}
	return 0;
}

void on_rx()
{
	char c = uart_getc();
	if (c == '\r') {
		uart_write("\r\n", 2);
	}
	else if (c == 127) {
		uart_write("\b \b", 3);
	}
	else {
		uart_write(&c, 1);
	}
}
