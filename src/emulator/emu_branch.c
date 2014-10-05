///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_branch.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "emu_private.h"

// Execute function
// Offsets the PC for the raspi
void branch(PtrToBeCast base)
{
  // make the casting to correct struct
  BranchInstr *i = (BranchInstr *) base;
  u32 offset = i->offset;
  if (offset & (1 << 23)) 
    offset = -(~offset & 0x007FFFFFu) - 1;
  *(i->pc) += offset + 1;
}

void terminate(PtrToBeCast base)
{
  TerminateInstr *i = (TerminateInstr *) base;
  *(i->halt) = 0;
}
