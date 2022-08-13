#ifndef __UART_H__
#define __UART_H__

#include <string.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include "common/bitmask.h"

#define UART_BUFFER_SIZE 64
#define UBRR(BAUD) (F_CPU/16/BAUD-1)

void uart_init        (int);
void uart_write       (const void *, int);
void uart_rx_callback (void (*)());
char uart_getc        ();

#endif /* __UART_H__ */
