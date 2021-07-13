#ifndef COMMON_H_
#define COMMON_H_

#define int16_t     short
#define int8_t      char
#define uint16_t    unsigned short
#define uint8_t     unsigned char

/* Bitwise Operations */

#define BIT_SET(REG, BIT_POS)  ( (REG) |= (1 << BIT_POS) )
#define BIT_CLR(REG, BIT_POS)  ( (REG) &= ( ~(1 << BIT_POS) ) )
#define BIT_FLIP(REG, BIT_POS) ( (REG) ^= (1 << BIT_POS) )

#endif // COMMON_H_
