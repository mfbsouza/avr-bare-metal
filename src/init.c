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
    
    // TODO: implement a C function to read bytes from the flash memory (AVR Harvard)
    
    /*
    extern uint8_t __text_end;
    extern uint8_t __data_start;
    extern uint8_t __data_end;
    extern uint8_t __bss_start;
    extern uint8_t __bss_end;

    uint8_t *src, *dest;
    
    // copying .data section to SRAM
    
    src = &__text_end;    // FLASH
    dest = &__data_start; // SRAM

    while (dest < &__data_end) {
        *(dest++) = *(src++);
    }

    // initializing the .bss section to zero in the SRAM

    dest = &__bss_start;
    while (dest < &__bss_end) {
        *(dest++) = 0;
    }
    */

    // call main and hope its working
    main();

    // halt
    while(1);
}
