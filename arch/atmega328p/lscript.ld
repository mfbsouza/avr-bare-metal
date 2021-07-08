ENTRY (__Init)

MEMORY
{
    FLASH (RX) : ORIGIN = 0, LENGTH = 32K
    SRAM (RXW) : ORIGIN = 0x800100, LENGTH = 2K
}

SECTIONS
{
    .text : {
        *(.vectors)
        *(.init)
        *(.text)
        *(.rodata)
        . = ALIGN(2);
        __end_of_text = .;
    }> FLASH

    .data : {
        __start_of_data = .;
        *(.data)
        . = ALIGN(1);
        __end_of_data = .;
    }> SRAM AT> FLASH

    .bss : {
        __start_of_bss = .;
        *(.bss)
        *(.COMMON)
        . = ALIGN(1);
        __end_of_bss = .;
    }> SRAM
}