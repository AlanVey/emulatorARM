///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_single_data_trfr.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "emu_private.h"

// Execute function
// Deals with single data transfer
void singleDataTransfer(PtrToBeCast base)
{
  // make the appropriate casting
  SingleDataInstr *i = (SingleDataInstr *) base;
  // find the op2 value from appropriate shifting
  u32 offset = (*(i->exShift))(i->cpsr, *(i->op2), *(i->shift), 0);
  u32 basePtr = *i->op1;
  // generate unique code for each modifier
  // TODO - stop using separate vars for the p u & l
  int code = i->pul;
  if (i->pc) basePtr = (basePtr + 1)*4;
  // switch for the op1 modifiers
  switch (code) {
    //     Pre and Up
    case 0x06u: case 0x07u: basePtr += offset; break; // for  U
    //     Pre and Down
    case 0x04u: case 0x05u: basePtr -= offset; break; // for ~U
  }
  // printf("Base pointer is %d\n", basePtr);
  u32 *finalDestination = i->des;
  if (basePtr < MEMSIZE)
  {
    // switch for the des modifiers
    switch(code) {
      //     Is Load
      case 0x01u: case 0x03u:
      case 0x05u: case 0x07u: 
        *i->des = _memget(basePtr); break;
      //     Is Store
      case 0x00u: case 0x02u:
      case 0x04u: case 0x06u: 
        finalDestination = _memset(basePtr, *i->des);  // for ~L
        break;
    }
  }
  else printf("Error: Out of bounds memory access at address 0x%08x\n", basePtr);
  switch (code) {
    //     Post and Up
    case 0x02u: case 0x03u: *i->op1 = basePtr + offset; break; // for  U
    //     Post and Down
    case 0x00u: case 0x01u: *i->op1 = basePtr - offset; break; // for ~U
  }
}
