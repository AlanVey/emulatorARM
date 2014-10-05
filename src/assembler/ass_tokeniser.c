///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_tokeniser.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "ass_private.h"

#define OP_MAX_ARGS 6 

static char** tokeniseLine(char* string_line);

char*** tokeniser(char* path)
{
  uint32_t curr_line = 0;
  uint32_t num_lines = countLines(path);
  char*** tokens = calloc(1, num_lines * OP_MAX_ARGS * sizeof(void*));
  char** string_lines = readInstrs(path, num_lines);

  for (; curr_line < num_lines; curr_line++)
  {
    tokens[curr_line] = tokeniseLine(string_lines[curr_line]);
  }
  return tokens;
}

///////////////////////////////////////////////////////////////////////////////
// Helper Methods
///////////////////////////////////////////////////////////////////////////////

static char** tokeniseLine(char* string_line)
{
  char** line = calloc(1, OP_MAX_ARGS * sizeof(void*));
  uint32_t token = 0;
  line[token] = strtok(string_line, " ,");

  while (token < OP_MAX_ARGS)
  {
    line[++token] = strtok(NULL, " ,");
  }
  return line;
}
