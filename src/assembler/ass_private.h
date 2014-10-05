///////////////////////////////////////////////////////////////////////////////
// C Group Project - First Year
// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// File: ass_private.c
// Group: 21
// Members: amv12, lmj112, skd212
///////////////////////////////////////////////////////////////////////////////

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define REG_D(x) (x << 16)
#define REG_N(x) (x << 12)
#define REG_S(x) (x << 8)
#define REG_M(x) (x << 0)

#define DATA void*
#define KEY char*

typedef struct node node;

uint32_t  regToInt                 (  char* reg  );
uint8_t   arrayContains            (  char* item, 
                                      char** array, 
                                      uint32_t array_length  );
uint32_t  toInt                    (  char* integer  );
uint32_t  countLines               (  char* path  );
char**    readInstrs               (  char* path, 
                                      uint32_t num_lines  );
int       writeInstrs              (  char* path, 
                                      uint32_t* ass_instrs, 
                                      uint32_t num_instrs  );
node*     makeRBT                  (  void  );
node*     get                      (  node* root, 
                                      KEY key  );
void      insert                   (  node* root, 
                                      node* parent, 
                                      KEY key, 
                                      DATA data  );
char***   tokeniser                (  char* path  );
uint32_t  ass_data_processing      (  char** line  );
uint32_t  ass_multiply             (  char** line  );
uint32_t  ass_branch               (  char** line, 
                                      node* symbol_table  );
uint32_t  ass_single_data_transfer (  char** line, 
                                      node* symbol_table  );
