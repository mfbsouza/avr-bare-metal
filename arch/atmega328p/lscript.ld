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
        __text_end = .;
    }> FLASH

    .data : {
        __data_start = .;
        *(.data)
        . = ALIGN(1);
        __data_end = .;
    }> SRAM AT> FLASH

    .bss : {
        __bss_start = .;
        *(.bss)
        *(.COMMON)
        . = ALIGN(1);
        __bss_end = .;
    }> SRAM
}
