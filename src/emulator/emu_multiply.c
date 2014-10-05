///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_multiply.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "emu_private.h"

// Execute function
// Deals with the multiplication, ideally with 2s complement
void multiply(PtrToBeCast base)
{
  // cast to appropriate struct type
  MultiplyInstr* i = (MultiplyInstr*) base;
  // make calculation, move into destination
  u32 acc = 0; if (i->acc) acc = *i->acc;
  *(i->des) = *i->op1 * *i->op2 + acc;
  // if required, mark the flags
  if (i->s) setflags(i->cpsr, *(i->des));
}
