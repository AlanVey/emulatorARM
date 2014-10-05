///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_utilities.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "ass_private.h"

uint32_t regToInt(char* reg)
{
  return toInt(&reg[1]);
}

uint8_t arrayContains(char* item, char** array, uint32_t array_length)
{
  uint32_t i = 0;
  for(; i < array_length ; i++)
  {
    if(strcmp(item, array[i]) == 0)
    {
      return 1;
    }
  }
  return 0;
}

uint32_t toInt (char* integer)
{
  return (uint32_t)strtol(integer, NULL, 0);
}

uint32_t countLines(char* path)
{
  FILE* file = fopen(path, "rt");
  uint32_t num_lines = 1;
  uint32_t num_chars = 0;
  int ch = 0;

  while ((ch = fgetc(file)) != EOF)
  {
    fseek(file, num_chars++, SEEK_SET);
    if((char)ch == '\n')
    {
      num_lines++;
    }
  }
  fclose(file);
  return num_lines;
}
