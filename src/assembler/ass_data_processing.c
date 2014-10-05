///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_data_processing.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "ass_private.h"

static uint32_t operand_2(char** op_2);
static uint32_t expression(char* op_2, uint32_t max_size);
static uint32_t registor(char** op_2);

uint32_t ass_data_processing(char** line)
{
  uint32_t instr = 0xE0000000;
  char* set_CPRS [3] = {"tst", "teq", "cmp"};

  if(strcmp(line[0], "mov") == 0)
  {
    instr |= (0xE0900000 | operand_2(&line[2]) | REG_D(regToInt(line[1])));
  }
  else if(arrayContains(line[0], set_CPRS, 3))
    // make arrays contains return num so dont have to use strcmp below
  {
    instr |= (operand_2(&line[2]) | REG_N(regToInt(line[1])));

    if (strcmp(line[0], "tst") == 0)
    {
      instr |= 0x0110000;
    }
    else if(strcmp(line[0], "teq") == 0)
    {
      instr |= 0x01300000;
    }
    else
    {
      instr |= 0x01500000;
    }
  }
  else
  {
    instr |= (operand_2(&line[3]) | REG_N(regToInt(line[2])) 
          | REG_D(regToInt(line[1])));

    if (strcmp(line[0], "and") == 0)
    {
      return instr;
    }
    else if(strcmp(line[0], "eor") == 0)
    {
      instr |= 0x00200000;
    }
    else if(strcmp(line[0], "sub") == 0)
    {
      instr |= 0x00400000;
    }
    else if(strcmp(line[0], "rsb") == 0)
    {
      instr |= 0x00600000;
    }
    else if(strcmp(line[0], "add") == 0)
    {
      instr |= 0x00800000;
    }
    else
    {
      instr |= 0x01800000;
    }
  }
  return instr;
}

///////////////////////////////////////////////////////////////////////////////
// Helper Methods
///////////////////////////////////////////////////////////////////////////////

static inline uint32_t operand_2(char** op_2)
{
  if(op_2[0][0] == '#')
  {
    return expression(&op_2[0][1], 255);
  }
  return registor(op_2);
}

static uint32_t expression(char* op_2, uint32_t max_size)
{
  uint32_t instr_op_2 = toInt(op_2);
  if(instr_op_2 > max_size)
  {
    //TODO: Dont exit deal with it differently
    printf("Opperand 2 too large to be an imemdiate\n\n");
    exit(EXIT_FAILURE);
  }
  return instr_op_2;
}

static uint32_t registor(char** op_2)
{
  uint32_t instr_op_2 = REG_M(regToInt(op_2[0]));

  if(strcmp(op_2[1], "lsr") == 0)
  {
    instr_op_2 |= 0x00000020;
  }
  else if(strcmp(op_2[1], "ror"))
  {
    instr_op_2 |= 0x00000040;
  }
  else if(strcmp(op_2[1], "asr"))
  {
    instr_op_2 |= 0x00000050;
  }

  if(op_2[2][0] == '#')
  {
    instr_op_2 |= (expression(&op_2[2][1], 31) << 7);
  }
  else
  {
    instr_op_2 |= (0x00000010 | REG_S(regToInt(op_2[2])));
  }

  return instr_op_2;
}
