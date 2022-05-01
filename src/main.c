#include "hal/gpio.h"
#include <util/delay.h>

int main ()
{
	gpio_init(GPIO_PB5, OUTPUT);

	while(1) {
		gpio_write(GPIO_PB5, !gpio_read(GPIO_PB5));
		_delay_ms(1000);
	}
	return 0;
}
