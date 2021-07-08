#include "common.h"

uint16_t count;         // .bss variable
uint16_t var = 30000;   // .data variable

int main () {

    count = 60000 - var;

    volatile uint8_t *DDRB  = (uint8_t *) 0x24; // stack variable
    volatile uint8_t *PORTB = (uint8_t *) 0x25; // stack variable

    // PB5 as output
    *DDRB |= 1 << 5;

    while (1) {
        // dumb delay
        for(uint16_t i = 0; i < count; i++);
        for(uint16_t j = 0; j < count; j++);
        for(uint16_t k = 0; k < count; k++);
        for(uint16_t l = 0; l < count; l++);
        // flip bit
        *PORTB ^= 1 << 5;
    }

    return 0;
}