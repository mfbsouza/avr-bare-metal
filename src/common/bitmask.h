#ifndef __BITMASK_H__
#define __BITMASK_H__

/* Bitwise Operations */

#define BIT_SET(REG, BIT_POS) ((REG) |= (1 << BIT_POS))
#define BIT_CLR(REG, BIT_POS) ((REG) &= (~(1 << BIT_POS)))
#define BIT_FLIP(REG, BIT_POS) ((REG) ^= (1 << BIT_POS))

#endif /*__BITMASK_H__*/
