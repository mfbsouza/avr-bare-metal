/**
 * init code objectives
 * 
 * Set up a default interrupt handler (done in vectors.s)
 * Initializes the stack pointer (modern avr mcu do this by it self)
 * Copy the .data section from FLASH to SRAM
 * Initializes the .bss section to 0 in the SRAM
 * Finally it calls your main() function.
 */

#include "common.h"

/* Functions Signature */

void __Init (void) __attribute__ ((section(".init"))) __attribute__ ((noreturn));
extern int main (void);

/* The Init Code */

void __Init (void) {

    extern uint8_t __end_of_text;
    extern uint8_t __start_of_data;
    extern uint8_t __end_of_data;
    extern uint8_t __start_of_bss;
    extern uint8_t __end_of_bss;

    uint8_t *src, *dest;
    
    // copying .data section to SRAM
    
    src = &__end_of_text;    // FLASH
    dest = &__start_of_data; // SRAM

    while (dest < &__end_of_data) {
        *(dest++) = *(src++);
    }

    // initializing the .bss section to zero in the SRAM

    dest = &__start_of_bss;
    while (dest < &__end_of_bss) {
        *(dest++) = 0;
    }

    // call main and hope its working
    main();

    // halt
    while(1);
}