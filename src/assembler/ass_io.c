///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_io.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "ass_private.h"

#define MAX_LINES 512

char** readInstrs(char* path, uint32_t num_lines)
{
  uint32_t curr_line = 0;
  FILE* file = fopen(path, "rt");
  char** string_lines = calloc(num_lines, MAX_LINES);

  fseek(file, 0, SEEK_SET);
  for (; fgets(string_lines[curr_line], MAX_LINES, file) != NULL; curr_line++);
  fclose(file);

  return string_lines;
}

int writeInstrs(char* path, uint32_t* ass_instrs, uint32_t num_instrs)
{
  FILE* file = fopen(path, "wb");
  fwrite(ass_instrs, 4, num_instrs, file);
  fclose(file);
  return 0;
}
