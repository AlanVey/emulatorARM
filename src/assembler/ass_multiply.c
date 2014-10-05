///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_multiply.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "ass_private.h"

uint32_t ass_multiply(char** line)
{
  if(strcmp(line[0], "mul") == 0)
  {
    return 0xE0000090 | (REG_D(regToInt(line[1])) 
                      | REG_M(regToInt(line[2])) | REG_S(regToInt(line[3])));
  }
  return 0xE0200090 | (REG_D(regToInt(line[1])) | REG_M(regToInt(line[2])) 
                    | REG_S(regToInt(line[3])) | REG_N(regToInt(line[4])));
}

