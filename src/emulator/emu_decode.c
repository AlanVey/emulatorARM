///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_decode.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

// PRE  - Given the raspi pointer, and the index in memory
//        from which to source the instruction
// DESC - Break apart the instruction and proceed to reduce
//        all stateless information into a single form
// POST - The corresponding index of the decoded memory inside
//        the raspi will contain a BaseInstr struct which
//        has been fully initialized with function and arguments

#include "emu_private.h"


///////////////////////////////////////////////////////////////////////////////
// SHIFT FUNCTION WRAPPERS
///////////////////////////////////////////////////////////////////////////////

static u32 lsl(u32* cpsr, u32 a, u32 b, u32 set) 
{ 
  if (set)
    setCflag(cpsr, (a >> (32 - (b - 1))) & FIRST_BIT_MASK);
  return LSL(a,b); 
}

static u32 lsr(u32* cpsr, u32 a, u32 b, u32 set) 
{
  if (set)
    setCflag(cpsr, (a << (32 - (b - 1))) & FIRST_BIT_MASK);
  return LSR(a,b); 
}

static u32 asr(u32* cpsr, u32 a, u32 b, u32 set) 
{ 
  if (set)
    setCflag(cpsr, (a << (32 - (b - 1))) & FIRST_BIT_MASK);
  return ASR(a,b); 
}

static u32 ror(u32* cpsr, u32 a, u32 b, u32 set) 
{ 
  if (set)
    setCflag(cpsr, (a << (32 - (b - 1))) & FIRST_BIT_MASK);
  return ROR(a,b); 
}

///////////////////////////////////////////////////////////////////////////////
// SHIFTING CALCULATIONS
///////////////////////////////////////////////////////////////////////////////

static void setShifting(Arm *raspi, u32 instr, ShiftingInstr *i)
{
  // retrieve last twelve bits for operand
  u32 rawOperand = instr & DATA_OPR_2;
  // set default shift type
  u8   shiftType = 0x3u;
  // default destuctive setting
  i->destructive = 1;
  if (instr & IMMEDIATE_MASK)  // if immediate is set
  {
    // get immediate part of operand
    u32 imm   = 0x00000000u | (rawOperand & OP_IMMD);
    // get value to rotate right by
    u8  val   = (rawOperand & OP_ROTATE) >> 0x08u;
    // generate operand by rotate right
    i->_op2   = ROR(imm, (val << 1));
    // set the exposed pointer to internal literal
    i->op2    = &(i->_op2);
    // set shift value to 0
    i->_shift = 0u;
    // set exposed shift pointer to the internal literal
    i->shift  = &(i->_shift);
  }
  else  // operand 2 is a register
  {
    // isolate shift information
    // shift is [ SHIFT ][ Rm ]
    u8 shift   = (rawOperand & OP_SHIFT) >> 4u;
    // reset the shifting type
    shiftType  = (shift & OP_SHIFT_TYPE) >> 1u;
    // assign pointer to the op2 as a raspi register
    i->op2     = &(raspi->r[rawOperand & RM_MASK]);
    // printf("Interested in THIS --- %d\n\n", rawOperand & RM_MASK);
    if (shift & 0x01u) // if bit 4 is 1
    {
      // mark as non-destructive shift
      i->destructive = 0;
      // then shift by value in register
      i->shift = &(raspi->r[(shift & 0xf0u) >> 4]);
    }
    else  // shift by a constant
    {
      // set literal value of shift
      i->_shift = shift >> 3;
      // set pointer to internal literal
      i->shift  = &(i->_shift);
    }
  }
  switch (shiftType)
  {
    // lsl
    case 0x0u: i->exShift = &lsl; break;
    // lsr
    case 0x1u: i->exShift = &lsr; break;
    // asr
    case 0x2u: i->exShift = &asr; break;
    // ror
    case 0x3u: i->exShift = &ror; break;
  }
}


BaseInstr *decodeInstruction(Arm *raspi, u32 index)
{
  u32 instr = mem.e[index];
  BaseInstr *base = &(mem.d[index]);
  // cond is the same no matter the instruction
  base->cond = instr >> 28;
  // set cpsr reg pointer, used in most
  base->cpsr = &(raspi->cpsr);
  //////////////////////////////////////////////////////////////////
  if (!instr)
  {
    TerminateInstr *i = (TerminateInstr *) base;
    i->cond           = AL_FLAG;
    i->function       = (Execute)&terminate;
    i->halt           = &(raspi->halt);
  }
  //////////////////////////////////////////////////////////////////
  else if (IS_MUL(instr))
  {
    // opcode matches multiplication (not long)
    MultiplyInstr *i = (MultiplyInstr *) base;
    // get the op1 from the instruction
    i->op1 = &(raspi->r[instr & MUL_RM_MASK]);
    // retrive op2 similarly from instr
    i->op2 = &(raspi->r[(instr & MUL_RS_MASK) >> 8 ]);
    i->s   = (instr >> 20) & 0x1u;
    if (instr & ACCUM_MASK)
    {
      i->acc = &(raspi->r[(instr & MUL_RN_MASK) >> 12]);
    }
    else { i->acc = 0; }
    // set the destination register
    i->des = &(raspi->r[(instr & MUL_RD_MASK) >> 16]);
    i->function = &multiply;
  }
  //////////////////////////////////////////////////////////////////
  else if (IS_DATA(instr))
  {
    // opcode matches data processing
    DataProcessingInstr *i = (DataProcessingInstr *) base;
    // isolate the opcode
    u8 opcode = (instr & DATA_OP_MASK) >> 21;
    // set pointer to op1 register
    i->op1    = &(raspi->r[(instr & RN_MASK) >> 16]);
    // set pointer to destination register
    i->des    = &(raspi->r[(instr & RD_MASK) >> 12]);
    i->s      = (instr >> 20) & 0x1u;
    // set the shift function and immediate settings
    setShifting(raspi, instr, (ShiftingInstr*) i);
    // start a switch on the opcode
    switch (opcode)
    { // use switch to set the function 
      case AND: i->function = &and; break;
      case EOR: i->function = &eor; break;
      case SUB: i->function = &sub; break;
      case RSB: i->function = &rsb; break;
      case ADD: i->function = &add; break;
      // case ADC: case SBC: case RSC:
      case TST: i->function = &tst; break;
      case TEQ: i->function = &teq; break;
      case CMP: i->function = &cmp; break;
      // case CMN:
      case ORR: i->function = &orr; break;
      case MOV: i->function = &mov; break;
      // case BIC: case MVN:
    }
  }
  //////////////////////////////////////////////////////////////////
  else if (IS_S_DATA(instr))
  {
    // opcode matches single data transfer
    SingleDataInstr *i = (SingleDataInstr *) base;
    i->function = (Execute)&singleDataTransfer;
    // extract the p u and l flags
    int p = (instr & P_INDEX_MASK) >> 24,
        u = (instr & S_DATA_UP) >> 23,
        l = (instr & LOAD_STORE_MASK) >> 20;
    i->pul = (p << 2) + (u << 1) + l;
    int regNo = (instr & RN_MASK) >> 16;
    switch (regNo)
    {
      case 13: i->op1 = &raspi->sp; break;
      case 14: i->op1 = &raspi->lr; break;
      case 15: i->op1 = &raspi->pc; i->pc = 0x7u; break;
      default: i->op1 = &raspi->r[regNo];
    }
    i->des = &(raspi->r[(instr & RD_MASK) >> 12]);
    // modify instruction for immediate idiosyncrasy
    instr ^= IMMEDIATE_MASK;
    // sorting out shifting
    setShifting(raspi, instr, (ShiftingInstr*) i);
    i->function = &singleDataTransfer;
  }
  //////////////////////////////////////////////////////////////////
  else if (IS_BRANCH(instr))
  {
    // opcode matches a branch statement
    BranchInstr *i = (BranchInstr *) base;
    i->function    = (Execute)&branch;
    i->offset      = (instr & BRANCH_OFFSET);
    i->pc          = &(raspi->pc);
  }
  return (BaseInstr *) & (mem.d[index]);
}
