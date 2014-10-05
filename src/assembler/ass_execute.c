///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_execute.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include "ass_private.h"

static node* createSymbolTable(char*** tokens, uint32_t num_lines);
static uint32_t* assemble(char*** tokens, uint32_t num_lines);

int startAssembler(int argc, char **argv)
{
  if(argc < 3)
  {
    return 1;
  }
  return writeInstrs(argv[2], 
                     assemble(tokeniser(argv[1]), countLines(argv[1])),
                     0); // TODO;
}

///////////////////////////////////////////////////////////////////////////////
// Helper Methods
///////////////////////////////////////////////////////////////////////////////

static uint32_t* assemble(char*** tokens, uint32_t num_lines)
{
  uint32_t i = 0;
  uint32_t* ass_instrs = calloc(num_lines, 4);
  char* data_processing[12] =     {"add", "sub", "rsb", "and", "eor", 
                                   "orr", "mov", "tst", "teq", "cmp", 
                                   "lsl", "andeq"};
  char* multiply[2] =             {"mul", "mla"};
  char* single_data_transfer[2] = {"ldr", "str"};
  char* branch[7] =               {"beq", "bne", "bge", "blt", "bgt", 
                                   "ble", "b"};
  node* symbol_table = createSymbolTable(tokens, num_lines);

  for (; i < num_lines; i++)
  {
    if(arrayContains(tokens[i][0], data_processing, 12))
    {
      ass_instrs[i] = ass_data_processing(tokens[i]);
    }
    else if(arrayContains(tokens[i][0], multiply, 2))
    {
      ass_instrs[i] = ass_multiply(tokens[i]);
    }
    else if(arrayContains(tokens[i][0], single_data_transfer, 2))
    {
      ass_instrs[i] = ass_single_data_transfer(tokens[i], symbol_table);
    }
    else if(arrayContains(tokens[i][0], branch, 7))
    {
      ass_instrs[i] = ass_branch(tokens[i], symbol_table);
    }
    else
    {
      printf("\nLabel: %s\n", tokens[i][0]);
    }
  }
  return ass_instrs;
}

static node* createSymbolTable(char*** tokens, uint32_t num_lines)
{
  node* symbol_table = makeRBT();
  char* token;
  uint32_t curr_line = 0;
  for(; curr_line < num_lines; curr_line++)
  {
    token = tokens[curr_line][0];
    if(token[strlen(token) - 1] == ':')
    {
      insert(symbol_table, NULL, token, &(tokens[curr_line + 1][0]));
    }
  }
  return symbol_table;
}
