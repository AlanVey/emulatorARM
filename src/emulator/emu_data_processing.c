///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_data_processing.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "emu_private.h"

// macros for applying the functions, allows for
// DRYer function bodies
#define  APPLY(i, op) *i->op1 op i->_op2
#define _APPLY(i, op) i->_op2 op *i->op1

// Stage 1 of any data processing instruction, cast the given
// pointer and calculate the required shift. Return the pointer
// for further use (though of course as inline, not quite that)
static inline DataProcessingInstr* castAndShift(PtrToBeCast base)
{
  // make cast to the data processing struct
  DataProcessingInstr* i = (DataProcessingInstr*) base;
  // calculate the value of op2 using the shifting function
  i->_op2 = (*(i->exShift))(i->cpsr, *(i->op2), *(i->shift), i->s);
  if (i->destructive) *i->op2 = i->_op2;
  // return the casted and shift calculated struct
  return i;
}

// Stage 2 of most data processing, save the result into rd
// and then handle the flag setting
static inline void saveAndSet(DataProcessingInstr* i, u32 res)
{
  // calculate final result using the above
  *(i->des) = res; 
  // if required, set the flags
  if (i->s) setflags(i->cpsr, *(i->des));
}

// Execute function                                        !! AND !!
// Deals with bitwise and functions
void and(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, APPLY(i, &));
}

// Execute function                                        !! EOR !!
// Deals with bitwise exclusive or
void eor(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, APPLY(i, ^));
}

// Execute function                                        !! SUB !!
// Deals with subtraction a - b
void sub(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, APPLY(i, -));
}

// Execute function                                        !! RSB !!
// Deals with subtraction b - a
void rsb(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, _APPLY(i, -));
}

// Execute function                                        !! ADD !!
// Deals with addition
void add(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, APPLY(i, +));
}

// Execute function                                        !! TST !!
// Deals with AND but without writing to destination
void tst(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // if required, set flags (sort of redundant, right?)
  if(i->s) setflags(i->cpsr, APPLY(i, &));
}

// Execute function                                        !! TEQ !!
// Deals with EOR but without writing to destination
void teq(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // once again, flags
  if(i->s) setflags(i->cpsr, APPLY(i, ^));
}

// Execute function                                        !! CMP !!
// Basically the subtraction, without writing to des
void cmp(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // set flags
  if(i->s) setflags(i->cpsr, APPLY(i, -));
}

// Execute function                                        !! ORR !!
// Handles bitwise ORing
void orr(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, APPLY(i, |));
}

// Execute function                                        !! MOV !!
// Write to destination operand2
void mov(PtrToBeCast base)
{
  // deal with the casting and shift calculation
  DataProcessingInstr* i = castAndShift(base);
  // calc final, save and set flags if appropriate
  saveAndSet(i, *(i->op2));
}
