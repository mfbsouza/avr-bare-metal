#include "uart.h"


static unsigned char buffer[UART_BUFFER_SIZE];
static unsigned char head = 0;
static unsigned char tail = 0;
static unsigned char count = 0;
static void (*rx_callback) (void) = NULL;

static void uart_putc();

ISR(USART_TX_vect)
{
	if (count != 0) {
		uart_putc();
	}
}

ISR(USART_RX_vect)
{
	if (rx_callback != NULL) {
		rx_callback();
	}
}

void uart_init(int baudrate)
{
	/* setting uart speed */
	UBRR0L = UBRR(baudrate) & 0xFF;
	UBRR0H = UBRR(baudrate) >> 8;

	/* mode: async usart */
	BIT_CLR(UCSR0C, UMSEL00);
	BIT_CLR(UCSR0C, UMSEL01);
	
	/* frame size: 8bit */
	BIT_SET(UCSR0C, UCSZ00);
	BIT_SET(UCSR0C, UCSZ01);

	/* bit parity: disable */
	BIT_CLR(UCSR0C, UPM00);
	BIT_CLR(UCSR0C, UPM01);

	/* stop bit: 1 bit */
	BIT_CLR(UCSR0C, USBS0);
	
	/* interrupt on TX & RX complete flag */
	BIT_SET(UCSR0B, TXCIE0);
	BIT_SET(UCSR0B, RXCIE0);
	sei();

	/* enable transmitter and receiver */
	BIT_SET(UCSR0B, RXEN0);
	BIT_SET(UCSR0B, TXEN0);
}

void uart_write(const void *data, int size)
{
	unsigned char *dest = NULL;
	int i;

	/* wait until you can store more data in the buffer */
	while ((count + size) >= UART_BUFFER_SIZE);

	/* cpy data to tx buffer */
	for (i = 0; i < size; i++) {
		dest = buffer + head;
		*dest = *(unsigned char *)(data+i);
		head = (head + 1) % UART_BUFFER_SIZE;
	}
	count += size;

	/* trigger the TX interrupt sending the first char */
	if (BIT_GET(UCSR0A, UDRE0)) {
		uart_putc();
	}
}

static void uart_putc()
{
	char c;
	c = buffer[tail];
	UDR0 = c;
	tail = (tail + 1) % UART_BUFFER_SIZE;
	count--;
}

char uart_getc()
{
	char c = UDR0;
	return c;
}

void uart_rx_callback (void (*callback)())
{
	rx_callback = callback;
}
