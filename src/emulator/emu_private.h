///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_private.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include <stdint.h>
#include <stdio.h>

typedef uint8_t   u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

#define NO_OF_REGS 16
#define MEMSIZE 65536

// required for C lexigraphical compilation
typedef void *PtrToBeCast;
// functions to apply shifting
typedef u32 (*Shifter)(u32*, u32, u32, u32);
// typedef of execute function with dummy pointer arg
// will really take a BaseStruct address representing
// all the below types
typedef void (*Execute)(PtrToBeCast);

//////////////////////////////////////////////////////
// BASE //////////////////////////////////////////////
// Defines the two key components of every decoded
// instruction, the cond flag that is required to be
// checked on execution and the function to call on
// execution, which will take the address of the struct
// itself, fixing the base pointer from where it can
// fetch it's arguments
#define BASE         \
  u8 cond;           \
  u32* cpsr;         \
  Execute function;  

//////////////////////////////////////////////////////
// SHIFTING ARGS /////////////////////////////////////
// Inherits from base, contains standard cond flag and
// address of function to be executed by the emulator
// along with function specific pointers to registers,
// memory allocation for operand literals and a shifter
#define SHIFTING_ARGS \
  u32* op1;           \
  u32* op2;           \
  u32* shift;         \
  u32 _op2;           \
  u32 _shift;         \
  Shifter exShift;    \
  u32* des; u8 destructive;

//////////////////////////////////////////////////////
// BASE STRUCT ///////////////////////////////////////
// type to represent the LARGEST of the below structs
// in memory, allowing for rapid memory access in a
// selection of calloced memory
typedef struct
{
  BASE
  char padding[108];
} BaseInstr;


typedef struct
{
  BASE
  u8 *halt;
} TerminateInstr;

//////////////////////////////////////////////////////
// SHIFTING INSTRUCTIONS /////////////////////////////
//////////////////////////////////////////////////////

// the basic shifting intruction that can be used
// for setting immediate values and the pre-execution
// shift
typedef struct   // for type checking only
{
  BASE
  SHIFTING_ARGS
} ShiftingInstr;

// DATA PROCESSING instructions require nothing more
// than that determined by the default base, hence
// repeated typedef for readability only
typedef struct   //  < BaseInstr
{
  BASE
  SHIFTING_ARGS
  u8 s; 
} DataProcessingInstr;

// SINGLE DATA PROCESSING instructions also make use
// of the staple args and require immediate shifting
// to be set, along with specific p u and l flags
typedef struct   //  < BaseInstr
{
  BASE
  SHIFTING_ARGS
  u8 pul; u8 pc;
  u8 s;
} SingleDataInstr;

//////////////////////////////////////////////////////
// MULTIPLY INSTRUCTION //////////////////////////////
//////////////////////////////////////////////////////

// TODO - Verify that multiply instruction
typedef struct    //  < BaseInstr
{
  BASE
  u32 *op1;
  u32 *op2;
  u32 *acc;
  u32 *des;
  u8     s;
} MultiplyInstr;

//////////////////////////////////////////////////////
// BRANCH INSTRUCTION ////////////////////////////////
//////////////////////////////////////////////////////

typedef struct    //  < BaseInstr
{
  BASE
  u32 *pc;
  u32 toAdd;
  u32 offset;   // to be signed on execution
} BranchInstr;

#define FLAG_MASKS

#define NO_OF_REGISTERS 13
#define NO_FILE_FOUND    1

#define N_MASK (u32) 1 << 31
#define Z_MASK (u32) 1 << 30
#define C_MASK (u32) 1 << 29
#define V_MASK (u32) 1 << 28

#define N_SET(i) ( ( i & N_MASK ) >> 31 )
#define Z_SET(i) ( ( i & Z_MASK ) >> 30 )
#define C_SET(i) ( ( i & C_MASK ) >> 29 )
#define V_SET(i) ( ( i & V_MASK ) >> 28 )

#define EQ_FLAG 0x00u
#define NE_FLAG 0x01u
#define GE_FLAG 0x0au
#define LT_FLAG 0x0bu
#define GT_FLAG 0x0cu
#define LE_FLAG 0x0du
#define AL_FLAG 0x0eu

#define AND 0x00u
#define EOR 0x01u
#define SUB 0x02u
#define RSB 0x03u
#define ADD 0x04u
#define ADC 0x05u
#define SBC 0x06u
#define RSC 0x07u
#define TST 0x08u
#define TEQ 0x09u
#define CMP 0x0au
#define CMN 0x0bu
#define ORR 0x0cu
#define MOV 0x0du
#define BIC 0x0eu
#define MVN 0x0fu

#define MUL_MASK         0x0fc000f0u
#define DATA_MASK        0x0c000000u
#define BLOCK_DATA_MASK  0x08000000u
#define S_DATA_MASK      0x04000000u
#define BRANCH_MASK      0x0a000000u

#define DATA_TEMPLATE    0x00000000u
#define MUL_TEMPLATE     0x00000090u
#define S_DATA_TEMPLATE  0x04000000u
#define BRANCH_TEMPLATE  0x0a000000u

#define IS_MUL(i)        ((MUL_MASK    & i) == 0x00000090u)
#define IS_DATA(i)       ((DATA_MASK   & i) == 0x00000000u)
#define IS_S_DATA(i)     ((S_DATA_MASK & i) == 0x04000000u)
#define IS_BRANCH(i)     ((BRANCH_MASK & i) == 0x0a000000u)

#define IMMEDIATE_MASK   0x02000000u
#define DATA_OP_MASK     0x01e00000u
#define RN_MASK          0x000f0000u
#define RD_MASK          0x0000f000u
#define RS_MASK          0x00000f00u
#define MUL_RD_MASK      0x000f0000u
#define MUL_RN_MASK      0x0000f000u
#define MUL_RS_MASK      0x00000f00u
#define MUL_RM_MASK      0x0000000fu
#define RM_MASK          0x0000000fu
#define DATA_OPR_2       0x00000fffu
#define BRANCH_OFFSET    0x00ffffffu
#define BRANCH_CTRL      0x00800000u
#define S_DATA_OFFSET    0x00000fffu
#define S_DATA_UP        0x00800000u
#define SET_COND_MASK    0x00100000u
#define ACCUM_MASK       0x00200000u
#define P_INDEX_MASK     0x01000000u
#define LOAD_STORE_MASK  0x00100000u
#define OP_ROTATE        0x00000f00u
#define OP_IMMD          0x000000ffu
#define OP_SHIFT         0x00000ff0u
#define OP_SHIFT_TYPE    0x00000006u
#define SET_FLAGS_S      0x00100000u
#define FIRST_BIT_MASK   0x00000001u

#define MSB 0x80000000u
#define LSL(i,v) (i << v)
#define LSR(i,v) (i >> v)
#define ASR(i,v) (LSR(i,v) | (i & MSB))
#define ROR(i,v) (i >> v) | LSL(i, (0x20u - v))

#define MAX_CHAR_PER_LINE 512
#define MAX_ARG_PER_LINE 7

#define OPCODE_SHIFT(o)    o << 21
#define COND_SHIFT(i)   (u32)(i << 28)
#define SET_SHIFT(i)    (u32)(i << 20)

#define COMPUTES 0
#define SINGLE_OP_ASSIGNS 1
#define SETS_CPSR 2

#define DATA_RD_SHIFT(i) i << 12
#define DATA_RN_SHIFT(i) i << 16

#define REG(i) atoi(i+1)

#define IS_IMMEDIATE(operand) operand[0] == '#'
#define IS_SYMBOL(s) s[strlen(s) - 1] == ':'

// Set up program state as a C Struct
typedef struct
{
  u32* e;
  BaseInstr* d;
} Memory;

Memory mem;

typedef struct
{
  u32 *r;        // registers
  u32 sp;        // R[13] <- stack pointer
  u32 lr;        // R[14] <- link register
  u32 pc;        // R[15] <- program counter
  u32 cpsr;      // R[16] <- flags
  u8  halt;      // a specific halting flag
} Arm;

typedef struct
{
  BASE
  int entry;
  Arm* raspi;
} EmptyInstr;

inline u32 _memget(u32 addr)
{
  u8 *picker = ((u8*)mem.e) + addr;
  u32 *word  = (u32*) picker;
  return *word; 
}

inline u32* _memset(u32 addr, u32 val)
{
  u8 *picker = ((u8*)mem.e) + addr;
  u32 *word  = (u32*) picker;
  *word = val;
  return word;
}

// Declared in header due to static
inline void setflags(u32* cpsr, u32 result)
{
  // set the N flag
  *(cpsr) |= (result & N_MASK);
  // if the result indicates...
  if (!result)
  { // turn Z on
    *cpsr |= Z_MASK; return;
  } // else turn Z off
  *cpsr &= ~Z_MASK;
}

inline void setCflag(u32* cpsr, u32 carryOut)
{
  *cpsr &= ~C_MASK; 
  *cpsr |= (carryOut << 29);
}

void branch(PtrToBeCast base);
void terminate(PtrToBeCast base);
void and(PtrToBeCast base);
void eor(PtrToBeCast base);
void sub(PtrToBeCast base);
void rsb(PtrToBeCast base);
void add(PtrToBeCast base);
void tst(PtrToBeCast base);
void teq(PtrToBeCast base);
void cmp(PtrToBeCast base);
void orr(PtrToBeCast base);
void mov(PtrToBeCast base);
void multiply(PtrToBeCast base);
void singleDataTransfer(PtrToBeCast base);
u32 *loadBinaryFile(char *path, u32 *memory);
u32 writeBinaryFile(u32* instr, u32 noOfInstr, char* path);
BaseInstr *decodeInstruction(Arm *raspi, u32 index);
void printTestSuite(Arm *raspi);
