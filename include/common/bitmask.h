#ifndef BITMASK_H_
#define BITMASK_H_

/* Bitwise Operations */

#define BIT_SET(REG, BIT_POS)  ( (REG) |= (1 << BIT_POS) )
#define BIT_CLR(REG, BIT_POS)  ( (REG) &= ( ~(1 << BIT_POS) ) )
#define BIT_FLIP(REG, BIT_POS) ( (REG) ^= (1 << BIT_POS) )

#endif // BITMASK_H_
