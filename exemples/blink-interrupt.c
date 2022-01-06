#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 16000000UL
#include <util/delay.h>

#include <common/bitmask.h>

int main ()
{
	cli();
	TCCR1A = 0;
	TCCR1B = 0;
	OCR1A  = 15624;
	OCR1A = OCR1A >> 1;

	BIT_SET(TCCR1B, 3);
	BIT_SET(TCCR1B, 2);
	BIT_SET(TCCR1B, 0);

	BIT_SET(TIMSK1, 1); // timer compare interrupt 
	sei();

	// PB5 as output (internal led)
	BIT_SET(DDRB, 5);

	while (1) {
		_delay_ms(1);
	}
}

ISR(TIMER1_COMPA_vect)
{
	BIT_FLIP(PORTB, 5);
}
