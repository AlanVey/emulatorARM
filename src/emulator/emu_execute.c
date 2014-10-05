///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: emu_execute.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

// PRE  - Given - Arm struct pointer with memory preloaded
//              - Decoded memory setup with dummy function
//              - First memory address to use for execution
// DESC - Use the decoded memory path to run the execution function after
//        making the relevant flag checks. Nothing need be known about
//        the encoded memory.
// POST - The raspi's registers and memory represent their real life
//        siblings had the same machine code been executed on a 
//        raspberry pi.

#include "emu_private.h"
#include <stdlib.h>

void runRaspi(Arm *raspi, int entry, int suppress)
{
  // assign variables that will keep swapping,
  // thus avoiding repeated assignment overhead
  // a pointer to the cpsr register for convenience
  u32 *cpsr = &(raspi->cpsr);
  // set the program counter to the given entry point
  raspi->pc = entry;
  raspi->halt = 1;
  // the current instruction
  BaseInstr* crrt;
  // view from hereon out as the 'execution' stage
exec:
  crrt = &(mem.d[raspi->pc++]);
  // switch on the current instructions condition
  // if it in any way doesn't satisfy the conditions, then
  // jump to the next label- avoid execution of this instruction
  // entirely
  switch (crrt->cond)
  {
  case EQ_FLAG:
    if (!Z_SET(*cpsr)) goto next;
    break;
  case NE_FLAG:
    if ( Z_SET(*cpsr)) goto next;
    break;
  case GE_FLAG:
    if ( N_SET(*cpsr) != V_SET(*cpsr)) goto next;
    break;
  case LT_FLAG:
    if ( N_SET(*cpsr) == V_SET(*cpsr)) goto next;
    break;
  case GT_FLAG:
    if ( Z_SET(*cpsr) || ( N_SET(*cpsr) != V_SET(*cpsr))) goto next;
    break;
  case LE_FLAG:
    if (!Z_SET(*cpsr) && ( N_SET(*cpsr) == V_SET(*cpsr))) goto next;
    break;
  case AL_FLAG: break;
  } 
  // if we pass the condition checks, then proceed to
  // call the function saved into the base instr struct
  crrt->function(crrt);
next:
  // if at any point we hit halt, then the halting function
  // will have been called and therefore the halt flag should
  // be set to all 0's. If this is the case, then __finish__
  if (!raspi->halt) goto fini;
  // else jump back to execution after we've
  // fetched the next instruction
  goto exec;
fini:
  // on finish, dump the current raspberry pi registers and
  // non-zero memory location/value pairs
  if (!suppress)
    // printOut(raspi);
    printTestSuite(raspi);
}

///////////////////////////////////////////////////////////////////////////////
// DECODING FUNCTIONS
///////////////////////////////////////////////////////////////////////////////



// ALSO AN EXECUTE FUNCTION - REQUIRED!!!
// PRE  - Given an Arm pointer with loaded memory
//        An entry point from whence to begin the decode
// DESC - Decode all encoded memory indexes from the entry
//        point to (and including) the next branch statement
// POST - All decoded memory from the entry to the next branch will be
//        decoded, replaced with their BaseInstr representations 
static void decodeTillBranch(PtrToBeCast base)
{
  // i will be the empty instruction pointer
  EmptyInstr* i = (EmptyInstr*) base;
  // j will be the iterative measure
  u32 j = i->entry;
  Arm *raspi = i->raspi;
  do decodeInstruction(raspi, j++);
  // while not a branch statement, or not 0x00u
  while (!IS_BRANCH(mem.e[j - 1]) * mem.e[j - 1]);
  raspi->pc = raspi->pc - 1;
}

///////////////////////////////////////////////////////////////////////////////
// UTILITY FUNCITONS
///////////////////////////////////////////////////////////////////////////////

static void deallocRaspi(Arm** raspi)
{
  if (*raspi == NULL)
  {
    fprintf(stderr, "Not a valid raspi pointer (free)\n\n");
    exit(EXIT_FAILURE);
  }
  free(mem.e);
  free(mem.d);

  free((*raspi)->r);
  free(*raspi);
  *raspi = NULL;
}

static Arm *makeRaspi()
{
  // allocate and initialise the raspi struct
  Arm *raspi = (Arm *) calloc(1, sizeof(Arm));
  // allocate space for all the memory
  mem.e = (u32 *) calloc(1, sizeof(u32) * MEMSIZE);
  mem.d = (BaseInstr *) calloc(1, sizeof(BaseInstr) * MEMSIZE);
  for (int i = 0; i < MEMSIZE; i++)
  {
    // cast to the empty instruction type for initialization
    EmptyInstr* instr = (EmptyInstr*) &(mem.d[i]);
    // make the function point to the decodeTillBranch
    instr->function = &decodeTillBranch;
    instr->cond = AL_FLAG;
    // assign entry the value of the current array index
    instr->entry = i;
    instr->raspi = raspi;
  }
  // allocate space for all the registers
  raspi->r  = (u32 *) calloc(1, sizeof(u32) * NO_OF_REGISTERS);
  // load the contents of the file @ mempath
  return raspi;
}

int startEmulator(int argc, char** argv)
{
  char *path; int suppress = 1; 
  switch (argc)
  {
    // case 0 for testing purposes
    case 0: path = (char *)argv; break;
    case 2: path = argv[1]; suppress = 0; break;
    default: 
      fprintf(stderr, "No FILE provided.\n"); 
      return NO_FILE_FOUND;
  }
  Arm *raspi = makeRaspi();
  loadBinaryFile(path, mem.e);
  // begin the emulation
  runRaspi(raspi, 0, suppress);
  deallocRaspi(&raspi);
  return 0;
}
