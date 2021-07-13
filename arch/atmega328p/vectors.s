/* Macro for creating weak jmp instructions */
    .macro vector name
    .weak \name
    .set \name, __default_handler
    JMP \name
    .endm

/* ATmega328p Vector Table */
    .section .vectors
    .global __vectors
    .func __vectors
__vectors:
    JMP __Init
    vector INT0_ISR
    vector INT1_ISR
    vector PCINT0_ISR
    vector PCINT1_ISR
    vector PCINT2_ISR
    vector WDT_ISR
    vector TIMER2_COMPA_ISR
    vector TIMER2_COMPB_ISR
    vector TIMER2_OVF_ISR
    vector TIMER1_CAPT_ISR
    vector TIMER1_COMPA_ISR
    vector TIMER1_COMPB_ISR
    vector TIMER1_OVF_ISR
    vector TIMER0_COMPA_ISR
    vector TIMER0_COMPB_ISR
    vector TIMER0_OVF_ISR
    vector SPI_STC_ISR
    vector USART_RX_ISR
    vector USART_UDRE_ISR
    vector USART_TX_ISR
    vector USART_ADC_ISR
    vector EE_READY_ISR
    vector ANALOG_COMP_ISR
    vector TWI_ISR
    vector SPM_READY_ISR
    .endfunc

/* Default ISR Handler */
    .global __default_handler
    .func __default_handler
__default_handler:
    JMP __default_handler
    .endfunc
