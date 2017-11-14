%{

/* SPL01.y - SPL01 parser */
/* Author: Peter Parsons */
/* Revision: Oct 08 BCT */

/* Skeleton yacc file that can be used */
/* This file shows how a parser could build up a parse tree

   Do not use this until you need to, and understand some
   of the material on tree building and walking.             */

/* declare some standard headers to be used to import declarations
   and libraries into the parser. */

   
extern int yydebug;

   
#include <stdio.h>
#include <stdlib.h>

/* make forward declarations to avoid compiler warnings */
int yylex (void);
void yyerror (char *);

/* 
   Some constants.
*/

  /* These constants are used later in the code */
#define SYMTABSIZE     50
#define IDLENGTH       15
#define NOTHING        -1
#define INDENTOFFSET    2

  enum ParseTreeNodeType { PROGRAM, BLOCK, DECLARATIONS,  STATEMENT_BLOCK, STATEMENT, DECLARTIONS, ASSIGNMENT_STATEMENT, WRITE_STATEMENT,
							READ_STATEMENT, IF_STATEMENT, DO_STATEMENT, WHILE_STATEMENT, FOR_STATEMENT, FOR_BODY,
							OUTPUT_BLOCK, NEWLINE, CONSTANT, CHARACTER_CONSTANT, NUMBER_CONSTANT, CONDITIONAL, CONDITIONAL_BODY,
							COMPARATOR, OR, AND, EQUAL, NOT_EQUAL, GREATER_THAN, LESS_THAN, GREATER_THAN_EQUAL_TO, LESS_THAN_EQUAL_TO,
							EXPR, EXPR_MINUS, EXPR_PLUS, TERM, TERM_DIVIDE, TERM_MULTIPLY, FACTOR, FACTOR_BRACKETS, 
							FACTOR_CONSTANT, INTEGER_TYPE, REAL_TYPE, CHARACTER_TYPE, TYPE, INTEGER_CONSTANT, REAL_CONSTANT,
							MINUS_INTEGER_CONSTANT, MINUS_REAL_CONSTANT
							} ;  
							
  char* NodeName[] = 		{ 
							"PROGRAM", "BLOCK", "DECLARATIONS", "IDENTIFITER_BLOCK", "STATEMENT_BLOCK", "STATEMENT", "DECLARTIONS", "ASSIGNMENT_STATEMENT", "WRITE_STATEMENT",
							"READ_STATEMENT", "IF_STATEMENT", "DO_STATEMENT", "WHILE_STATEMENT", "FOR_STATEMENT", "FOR_BODY", 
							"OUTPUT_BLOCK", "NEWLINE", "CONSTANT", "CHARACTER_CONSTANT", "NUMBER_CONSTANT", "CONDITIONAL", "CONDITIONAL_BODY",
							"COMPARATOR", "OR", "AND", "EQUAL", "NOT_EQUAL", "GREATER_THAN", "LESS_THAN", "GREATER_THAN_EQUAL_TO", "LESS_THAN_EQUAL_TO",
							"EXPR", "EXPR_MINUS", "EXPR_PLUS", "TERM", "TERM_DIVIDE", "TERM_MULTIPLY", "FACTOR", "FACTOR_BRACKETS", 
							"FACTOR_CONSTANT", "INTEGER_TYPE", "REAL_TYPE", "CHARACTER_TYPE", "TYPE", "INTEGER_CONSTANT", "REAL_CONSTANT",
							"MINUS_INTEGER_CONSTANT", "MINUS_REAL_CONSTANT"
							} ;  										
                          /* Add more types here, as more nodes
                                           added to tree */

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef NULL
#define NULL 0
#endif

/* ------------- parse tree definition --------------------------- */

struct treeNode {
    int  item;
    int  nodeIdentifier;
    struct treeNode *first;
    struct treeNode *second;
    struct treeNode *third;
  };

typedef  struct treeNode TREE_NODE;
typedef  TREE_NODE        *TERNARY_TREE;

/* ------------- forward declarations --------------------------- */

TERNARY_TREE create_node(int,int,TERNARY_TREE,TERNARY_TREE,TERNARY_TREE);

#ifdef DEBUG
	void PrintTree(TERNARY_TREE t, int indent);
#endif	
void WriteCode(TERNARY_TREE t, int indent);

/* ------------- symbol table definition --------------------------- */

struct symTabNode {
    char identifier[IDLENGTH];
};

typedef  struct symTabNode SYMTABNODE;
typedef  SYMTABNODE        *SYMTABNODEPTR;

SYMTABNODEPTR  symTab[SYMTABSIZE]; 

int currentSymTabSize = 0;
%}

%start  program

%debug

%union 
{
    int iVal;
    TERNARY_TREE  tVal;
}

// These are lexical tokens

%token<iVal>	ID_T BRA_T KET_T NUMBER_CONSTANT_T

%token<iVal>	IF_T THEN_T ELSE_T END_IF_T DECLARATIONS_T
				FOR_T IS_T BY_T TO_T END_FOR_T WRITE_T READ_T NOT_T AND_T OR_T END_DO_T
				WHILE_T END_WHILE_T NEWLINE_T OF_T TYPE_T word 
				ASSIGNMENT_T EQUAL_TO_T NOT_EQUAL_T LESS_THAN_T GREATER_THAN_T
				LESS_THAN_EQUAL_TO_T GREATER_THAN_EQUAL_TO_T APOSTROPHE_T
				MULTIPLY_T ADD_T MINUS_T DIVIDE_T
				CHARACTER_CONSTANT_T INTEGER_CONSTANT_T REAL_CONSTANT_T
				CHARACTER_T INTEGER_T REAL_T CODE_T COMMA_T
    
// These tokens don't return a value
%token 		COLON_T FULL_STOP_T ENDP_T SEMI_COLON_T DO_T
    

// These rules return a type of tVal    
%type<tVal>  	program expr term factor statement_block statement 
				for_statement for_body if_statement declarations 
				assignment_statement  
				write_statement conditional conditional_body comparator output_block read_statement 
				character_constant constant number_constant while_statement do_statement block type



%%

program             	: ID_T COLON_T  block ENDP_T ID_T FULL_STOP_T
						{
							TERNARY_TREE parseTree;
							parseTree = create_node($1, PROGRAM, $3, NULL, NULL);
#ifdef DEBUG							
							PrintTree(parseTree, 0);
#endif							

							WriteCode(parseTree, 0);
							if($1 != $3)
							{
								/* IDs don't match work out how to handle this */
								
							}
							
						}
						;
						
						
block					: DECLARATIONS_T declarations CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2, $4, NULL);
						}
						| CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2, NULL, NULL);
						}
						
						
						
declarations			: ID_T OF_T TYPE_T type SEMI_COLON_T
						{
							$$ = create_node($1, DECLARTIONS, $4, NULL, NULL);
						}
						
						| ID_T OF_T TYPE_T type SEMI_COLON_T declarations
						{
							$$ = create_node($1, DECLARTIONS, $4, $6 , NULL);
						}
						| ID_T COMMA_T declarations
						{
							$$ = create_node($1, DECLARTIONS, $3, NULL, NULL);
						}
						;
	
						
statement_block			: statement_block SEMI_COLON_T statement 
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, $3, NULL);
						}
						| statement
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, NULL, NULL);
						}
						;
	
statement				: assignment_statement
						{
							$$ = create_node(ASSIGNMENT_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						| write_statement
						{
							$$ = create_node(WRITE_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						| read_statement
						{
							$$ = create_node(READ_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						| if_statement
						{
							$$ =  create_node(IF_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						| do_statement
						{
							$$ =  create_node(DO_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						| while_statement
						{
							$$ =  create_node(WHILE_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						| for_statement
						{
							$$ =  create_node(FOR_STATEMENT, STATEMENT, $1, NULL, NULL);
						}
						;
					
assignment_statement	: expr ASSIGNMENT_T ID_T
						{
							$$ = create_node($3, ASSIGNMENT_STATEMENT, $1, NULL, NULL);
						}
						;

write_statement			: WRITE_T BRA_T output_block KET_T
						{
							$$ = create_node(NOTHING, WRITE_STATEMENT, $3, NULL, NULL);
						}
						| NEWLINE_T
						{
							$$ = create_node(NOTHING, NEWLINE, NULL, NULL, NULL);
						}
						;
						
read_statement			: READ_T BRA_T ID_T KET_T
						{
							$$ = create_node($3, READ_STATEMENT, NULL, NULL, NULL);
						}
						;
						
if_statement			: IF_T conditional THEN_T statement_block END_IF_T
						{
							$$ = create_node(NOTHING, IF_STATEMENT, $2, $4, NULL);
						}
						| IF_T conditional THEN_T statement_block ELSE_T statement_block END_IF_T
						{
							$$ = create_node(NOTHING, IF_STATEMENT, $2, $4, $6);
						}
						;
						
do_statement			: DO_T statement_block WHILE_T conditional END_DO_T
						{
							$$ = create_node(NOTHING, DO_STATEMENT, $2, $4, NULL);
						}
						;
						
while_statement			: WHILE_T conditional DO_T statement_block END_WHILE_T
						{
							$$ = create_node(NOTHING, WHILE_STATEMENT, $2, $4, NULL);
						}		
						;
						
for_statement			: FOR_T for_body DO_T statement_block END_FOR_T
						{
							$$ = create_node(NOTHING, FOR_STATEMENT, $2, $4, NULL);
						}			
						;			
						
for_body				: ID_T IS_T expr BY_T expr TO_T expr 
						{
							$$ = create_node($1, FOR_BODY, $3, $5, $7);
						}
						;
					
output_block			: output_block COMMA_T term 
						{
							$$ = create_node(NOTHING, OUTPUT_BLOCK, $1, $3, NULL);
						}
						| term
						{
							$$ = create_node(NOTHING, OUTPUT_BLOCK, $1, NULL, NULL);
						}
						;
						

						
constant				: number_constant
						{
							$$ = create_node(NUMBER_CONSTANT, CONSTANT, NULL, NULL, NULL);
						}
						| character_constant
						{
							$$ = create_node(CHARACTER_CONSTANT, CONSTANT, NULL, NULL, NULL);
						}
						;
						
character_constant		: CHARACTER_CONSTANT_T
						{
							$$ = create_node(CHARACTER_CONSTANT, CHARACTER_CONSTANT, NULL, NULL, NULL);
						}
						;
						
number_constant			: INTEGER_CONSTANT_T
						{
							$$ = create_node(INTEGER_CONSTANT, NUMBER_CONSTANT, NULL, NULL, NULL);
						}
						| REAL_CONSTANT_T
						{
							$$ = create_node(REAL_CONSTANT, NUMBER_CONSTANT, NULL, NULL, NULL);
						}
						| MINUS_T INTEGER_CONSTANT_T
						{
							$$ = create_node(MINUS_INTEGER_CONSTANT, NUMBER_CONSTANT, NULL, NULL, NULL);
						}
						| MINUS_T REAL_CONSTANT_T
						{
							$$ = create_node(MINUS_REAL_CONSTANT, NUMBER_CONSTANT, NULL, NULL, NULL);
						}
						;
						
conditional				: conditional_body
						{
							$$ = create_node(NOTHING, CONDITIONAL, $1, NULL, NULL);
						}
						| conditional_body OR_T conditional
						{
							$$ = create_node(OR, CONDITIONAL, $1, $3, NULL);
						}
						| conditional_body AND_T conditional
						{
							$$ = create_node(AND, CONDITIONAL, $1, $3, NULL);
						}
						;

conditional_body		: expr comparator expr
						{
							$$ = create_node(NOTHING, CONDITIONAL_BODY, $1, $2, $3);
						}
						| NOT_T conditional_body
						{
							$$ = create_node($1, CONDITIONAL_BODY, $2, NULL, NULL);
						}
						
						
						
comparator				: EQUAL_TO_T
						{
							$$ = create_node(EQUAL, COMPARATOR, NULL, NULL, NULL);
						}
						| NOT_EQUAL_T
						{
							$$ = create_node(NOT_EQUAL, COMPARATOR, NULL, NULL, NULL);
						}
						| LESS_THAN_T
						{
							$$ = create_node(LESS_THAN, COMPARATOR, NULL, NULL, NULL);
						}
						| GREATER_THAN_T
						{
							$$ = create_node(GREATER_THAN, COMPARATOR, NULL, NULL, NULL);
						}
						| LESS_THAN_EQUAL_TO_T
						{
							$$ = create_node(LESS_THAN_EQUAL_TO, COMPARATOR, NULL, NULL, NULL);
						}
						| GREATER_THAN_EQUAL_TO_T
						{
							$$ = create_node(GREATER_THAN_EQUAL_TO, COMPARATOR, NULL, NULL, NULL);
						}
						;
						
expr					: term
						{
							$$ = create_node(NOTHING, EXPR, $1, NULL, NULL);
						}
						| expr ADD_T term
						{
							$$ = create_node("+", EXPR_PLUS, $1, $3, NULL);
						}
						| expr MINUS_T term
						{
							$$ = create_node("-", EXPR_MINUS, $1, $3, NULL);
						}
						
						;
						
term					: factor
						{
							$$ = create_node(NOTHING, TERM, $1, NULL, NULL);
						}
						| term MULTIPLY_T factor
						{
							$$ = create_node(NOTHING, TERM_MULTIPLY, $1, $3, NULL);
						}
						| term DIVIDE_T factor
						{
							$$ = create_node(NOTHING, TERM_DIVIDE, $1, $3, NULL);
						}
						;
						
factor					: ID_T
						{
							$$ = create_node($1, FACTOR, NULL, NULL, NULL);
						}
						| constant
						{
							$$ = create_node(NOTHING, FACTOR_CONSTANT, $1, NULL, NULL);
						}
						| BRA_T expr KET_T
						{
							$$ = create_node(NOTHING, FACTOR_BRACKETS, $2, NULL, NULL);
						}
						;
						
type					: INTEGER_T
						{
							$$ = create_node(INTEGER_TYPE, TYPE, NULL, NULL, NULL);
						}
						| REAL_T
						{
							$$ = create_node(REAL_TYPE, TYPE, NULL, NULL, NULL);
						}
						| CHARACTER_T
						{
							$$ = create_node(CHARACTER_TYPE, TYPE, NULL, NULL, NULL);
						}
%%

/* Code for routines for managing the Parse Tree */

TERNARY_TREE create_node(int ival, int case_identifier, TERNARY_TREE p1, TERNARY_TREE  p2, TERNARY_TREE  p3)
			
{
    TERNARY_TREE t;
    t = (TERNARY_TREE)malloc(sizeof(TREE_NODE));
    t->item = ival;
    t->nodeIdentifier = case_identifier;
    t->first = p1;
    t->second = p2;
    t->third = p3;
    return (t);
}

#ifdef DEBUG
void PrintTree(TERNARY_TREE t, int indent)
{
	if(t == NULL)
	{
		return;
	}
	int i;
	for(i = indent; i; i--)
	{
		printf(" ");
	}
	
	
	
	if(t->item != NOTHING)
	{
		
		switch(t->nodeIdentifier)
		{
			case INTEGER_TYPE:
				printf("Number: %d", t->item);
				break;
			case ID_T:
				printf("Identifier: %s\n", symTab[t->item]->identifier);
				break;
			case FACTOR:
				printf("Identifier: %s\n", symTab[t->item]->identifier);
				break;
			
				
		}
		
	}
	if(t->nodeIdentifier < 0 || t->nodeIdentifier > sizeof(NodeName))
	{
		
		printf("Uknown node identifier %d\n", t->nodeIdentifier);
	}
	else
	{
		printf(" nodeIdentifier: %s\n", NodeName[t->nodeIdentifier]);
	}
	PrintTree(t->first, indent + 2);
	PrintTree(t->second, indent + 2);
	PrintTree(t->third, indent + 2);
	
	
}
#endif

int Evaluate(TERNARY_TREE t)
{
	return 0 ;
	
}

void WriteCode(TERNARY_TREE t, int indent)
{
	if(t == NULL)
	{
		return;
	}
	
	switch(t->nodeIdentifier)
	{
		case(PROGRAM):
			printf("int main(void) {\n");
			WriteCode(t->first, indent);
			printf("}\n");
			break;
		case(DECLARATIONS):
			WriteCode(t->first, indent);
			WriteCode(t->second, indent);
			WriteCode(t->third, indent);
		
	}
	WriteCode(t->first, indent);
	WriteCode(t->second, indent);
	WriteCode(t->third,indent);
}

/* Put other auxiliary functions here */

#include "lex.yy.c"