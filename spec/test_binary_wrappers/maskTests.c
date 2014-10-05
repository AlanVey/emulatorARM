///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: masking_tests.c
// Group: 21
// Memebers: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "../../src/emulate.h"

int main(int argc, char** argv)
{
  int i = 0;
  u32 instr = (u32) atoi(argv[1]);

  if (IS_MUL(instr)) {
    i++;
    printf("M");
    return 0;
  } 
  
  if (IS_DATA(instr)) 
  {
    i++;
    printf("D");
    return 0;
  }

  if (IS_S_DATA(instr)) {
    i++;
    printf("S");
  }

  if (IS_BRANCH(instr)) {
    i++;
    printf("B");
  }

  if (i != 1) 
  {
    printf("  -  ");
    for (int j = 0; j < 32; j++)
    {
      if ((instr >> (32 - j - 1)) & 0x1u)
      {
        printf("1");
      }
      else
      {
        printf("0"); 
      }
    }
  }

  return 0;
}