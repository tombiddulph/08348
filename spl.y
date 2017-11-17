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


  enum ParseTreeNodeType
						{
							PROGRAM, DECLARATIONS, BLOCK_DECLARATIONS, BLOCK, STATEMENT_BLOCK,
							ASSIGNMENT_STATEMENT, WRITE_STATEMENT, READ_STATEMENT, IF_STATEMENT,
							IF_STATEMENT_ELSE, DO_STATEMENT, WHILE_STATEMENT, NEWLINE_STATEMENT,
							FOR_STATEMENT, FOR_BODY, WRITE_BLOCK, CONDITIONAL,
							CONDITIONAL_NOT, CONDITIONAL_AND, CONDITIONAL_OR, CONDITION, EXPR,
							VAL_ID, VAL_BRACKETS, VAL_NEGATIVE, VAL, COMPARATOR_EQUAL_TO,
							COMPARATOR_NOT_EQUAL_TO, COMPARATOR_LESS_THAN, COMPARATOR_GREATER_THAN,
							COMPARATOR_LESS_THAN_EQUAL_TO, COMPARATOR_GREATER_THAN_EQUAL_TO,
							OP_ADD, OP_MINUS, OP_MULTIPLY, OP_DIVIDE, TYPE_INT, TYPE_REAL, TYPE_CHARACTER,
							CONST_INT, CONST_REAL,CONST_CHARACTER, CONST
						};

	char *NodeName[] =	{	
							"PROGRAM", "DECLARATIONS", "BLOCK_DECLARATIONS", "BLOCK", "STATEMENT_BLOCK", 
							"ASSIGNMENT_STATEMENT", "WRITE_STATEMENT", "READ_STATEMENT", "IF_STATEMENT", 
							"IF_STATEMENT_ELSE", "DO_STATEMENT", "WHILE_STATEMENT", "NEWLINE_STATEMENT", 
							"FOR_STATEMENT", "FOR_BODY", "WRITE_BLOCK", "CONDITIONAL", 
							"CONDITIONAL_NOT", "CONDITIONAL_AND", "CONDITIONAL_OR", "CONDITION", "EXPR", 
							"VAL_ID", "VAL_BRACKETS", "VAL_NEGATIVE", "VAL", "COMPARATOR_EQUAL_TO", 
							"COMPARATOR_NOT_EQUAL_TO", "COMPARATOR_LESS_THAN", "COMPARATOR_GREATER_THAN", 
							"COMPARATOR_LESS_THAN_EQUAL_TO", "COMPARATOR_GREATER_THAN_EQUAL_TO", 
							"OP_ADD", "OP_MINUS", "OP_MULTIPLY", "OP_DIVIDE", "TYPE_INT", "TYPE_REAL", 
							"TYPE_CHARACTER", "CONST_INT", "CONST_REAL", "CONST_CHARACTER", "CONST"
						};						

//   enum ParseTreeNodeType { 
// 	  						PROGRAM, BLOCK, STATEMENT_BLOCK, STATEMENT, NEWLINE_STATEMENT, DECLARTIONS, ASSIGNMENT_STATEMENT, WRITE_STATEMENT,
// 							WRITE_BLOCK, DECLARATIONS, IF_STATEMENT_ELSE, CONDITION, VAL, OP_ADD, OP_MINUS, OP_MULTIPLY, OP_DIVIDE,
// 							READ_STATEMENT, IF_STATEMENT, DO_STATEMENT, WHILE_STATEMENT, FOR_STATEMENT, FOR_BODY,
// 							OUTPUT_BLOCK, NEWLINE, CONST, CHARACTER_CONSTANT, NUMBER_CONSTANT, CONDITIONAL, CONDITIONAL_BODY,
// 							COMPARATOR, OR, AND, EQUAL, NOT_EQUAL, GREATER_THAN, LESS_THAN, GREATER_THAN_EQUAL_TO, LESS_THAN_EQUAL_TO,
// 							EXPR, EXPR_MINUS, EXPR_PLUS, TERM, TERM_DIVIDE, TERM_MULTIPLY, FACTOR_BRACKETS, 
// 							FACTOR_CONSTANT, INTEGER_TYPE, REAL_TYPE, CHARACTER_TYPE, TYPE, INTEGER_CONSTANT, REAL_CONSTANT,
// 							MINUS_INTEGER_CONSTANT, MINUS_REAL_CONSTANT, ID_VAL
// 							} ;  
							
//   char* NodeName[] = 		{ 
// 							"PROGRAM"," BLOCK"," STATEMENT_BLOCK"," STATEMENT"," NEWLINE_STATEMENT"," DECLARTIONS"," ASSIGNMENT_STATEMENT"," WRITE_STATEMENT",
// 							"WRITE_BLOCK"," DECLARATIONS"," IF_STATEMENT_ELSE"," CONDITION"," VAL",  "OP_ADD", "OP_MINUS", "OP_MULTIPLY", "OP_DIVIDE",
// 							"READ_STATEMENT"," IF_STATEMENT"," DO_STATEMENT"," WHILE_STATEMENT"," FOR_STATEMENT","FOR_BODY", 
// 							"OUTPUT_BLOCK"," NEWLINE"," CONST"," CHARACTER_CONSTANT"," NUMBER_CONSTANT"," CONDITIONAL"," CONDITIONAL_BODY",
// 							"COMPARATOR"," OR"," AND"," EQUAL"," NOT_EQUAL"," GREATER_THAN"," LESS_THAN"," GREATER_THAN_EQUAL_TO"," LESS_THAN_EQUAL_TO", 
// 							"EXPR"," EXPR_MINUS"," EXPR_PLUS"," TERM"," TERM_DIVIDE"," TERM_MULTIPLY"," FACTOR_BRACKETS",
// 							"FACTOR_CONSTANT"," INTEGER_TYPE"," REAL_TYPE"," CHARACTER_TYPE"," TYPE"," INTEGER_CONSTANT"," REAL_CONSTANT", 
// 							"MINUS_INTEGER_CONSTANT"," MINUS_REAL_CONSTANT" ,"ID_VAL"
// 							} ;  							
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
    union{
		int item;
		char *cItem;
	};
    int  nodeIdentifier;
    struct treeNode *first;
    struct treeNode *second;
    struct treeNode *third;
  };

typedef  struct treeNode TREE_NODE;
typedef  TREE_NODE        *TERNARY_TREE;

/* ------------- forward declarations --------------------------- */

TERNARY_TREE create_node(int,int,TERNARY_TREE,TERNARY_TREE,TERNARY_TREE);
TERNARY_TREE create_node_characterArray(char*,int,TERNARY_TREE,TERNARY_TREE,TERNARY_TREE);
#ifdef DEBUG
	void PrintTree(TERNARY_TREE t);
	int sizeofString(char * str);
	#define NEWLINE "\n"
#endif	
void WriteCode(TERNARY_TREE t);

/* ------------- symbol table definition --------------------------- */

struct symTabNode {
    char identifier[IDLENGTH];
	char *nodeType;
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

%token<iVal> ID_T BRA_T INTEGER_CONSTANT_T REAL_CONSTANT_T CHARACTER_CONSTANT_T 


    
/* These tokens don't return a value */
%token 		COLON_T FULL_STOP_T ENDP_T SEMI_COLON_T  ASSIGNMENT_T EQUAL_TO_T 
			
			NOT_EQUAL_T LESS_THAN_EQUAL_TO_T LESS_THAN_T GREATER_THAN_EQUAL_TO_T 
			GREATER_THAN_T ADD_T MINUS_T MULTIPLY_T DIVIDE_T KET_T
			DECLARATIONS_T CODE_T OF_T TYPE_T CHARACTER_T INTEGER_T REAL_T
			IF_T THEN_T ELSE_T END_IF_T DO_T END_DO_T WHILE_T END_WHILE_T 
			 FOR_T END_FOR_T WRITE_T READ_T NEWLINE_T 
			NOT_T COMMA_T APOSTROPHE_T BY_T IS_T TO_T  OR_T AND_T



    

/* These rules return a type of tVal    */ 
 %type<tVal>  	program block declarations statement statement_block
				write_block conditional condition for_block
				expr val comp op type const



%%

program             	: ID_T COLON_T  block ENDP_T ID_T FULL_STOP_T
						{
							TERNARY_TREE parseTree;
							parseTree = create_node($1, PROGRAM, $3, NULL, NULL);
							
#ifdef DEBUG							
							PrintTree(parseTree);
#endif							

							
						}
						;
						
						
block					: DECLARATIONS_T declarations CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK_DECLARATIONS, $2, $4, NULL);
						}
						| CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2, NULL, NULL);
						}
						;
						
						
						
declarations			: ID_T OF_T TYPE_T type SEMI_COLON_T
						{
							$$ = create_node($1, DECLARATIONS, $4, NULL, NULL);
						}
						| ID_T OF_T TYPE_T type SEMI_COLON_T declarations
						{
							$$ = create_node(NOTHING, DECLARATIONS, $4, $6, NULL);							
						}
						| ID_T COMMA_T declarations
						{
							$$ = create_node($1, DECLARATIONS, $3, NULL, NULL);
						}
						;
											
statement_block			: statement SEMI_COLON_T statement_block
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, $3, NULL);
						}
						| statement
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, NULL, NULL);
						}
						;
	
statement				: expr ASSIGNMENT_T ID_T
						{
							$$ = create_node($3, ASSIGNMENT_STATEMENT, $1, NULL, NULL);
						}
						|  WRITE_T BRA_T write_block KET_T
						{
							$$ = create_node(NOTHING, WRITE_STATEMENT, $3, NULL, NULL);
						}
						| READ_T BRA_T ID_T KET_T
						{
							$$ = create_node($3, READ_STATEMENT, NULL, NULL, NULL);
						}
						| IF_T conditional THEN_T statement_block END_IF_T
						{
							$$ =  create_node(NOTHING, IF_STATEMENT, $2, $4, NULL);
						}
						| IF_T conditional THEN_T statement_block ELSE_T statement_block END_IF_T
						{
							$$ = create_node(NOTHING, IF_STATEMENT_ELSE, $2, $4, $6);
						}
						| DO_T statement_block WHILE_T conditional END_DO_T
						{
							$$ = create_node(NOTHING, DO_STATEMENT, $2, $4, NULL);
						}
						| WHILE_T conditional DO_T statement_block END_WHILE_T
						{
							$$ =  create_node(NOTHING, WHILE_STATEMENT, $2, $4, NULL);
						}
						| NEWLINE_T
						{
							$$ = create_node(NOTHING, NEWLINE_STATEMENT, NULL, NULL, NULL);
						}
						| FOR_T for_block statement_block END_FOR_T
						{
							$$ = create_node(NOTHING, FOR_STATEMENT, $2, $3, NULL);
						}
						;

for_block				: ID_T IS_T expr BY_T expr TO_T expr DO_T
						{
							$$ = create_node($1, FOR_BODY, $3, $5, $7);
						}						
						;

					
write_block				: val 
						{
							$$ = create_node(NOTHING, WRITE_BLOCK, $1, NULL, NULL);
						}
						| val COMMA_T write_block
						{
							$$ = create_node(NOTHING, WRITE_BLOCK, $1, $3, NULL);
						}
						;

conditional				: condition
						{
							$$ = create_node(NOTHING, CONDITIONAL, $1, NULL, NULL);
						}
						| NOT_T conditional
						{
							$$ = create_node_characterArray("!", CONDITIONAL_NOT, $2, NULL, NULL);
						}
						|  condition AND_T conditional
						{
							$$ = create_node_characterArray("&&", CONDITIONAL_AND, $1, $3, NULL);
						}
						| condition OR_T conditional
						{
							$$ = create_node_characterArray("||", CONDITIONAL_OR, $1, $3, NULL);
						}
						;

condition				: expr comp expr
						{
							$$ = create_node(NOTHING, CONDITION, $1, $2 ,$3);
						}
						;

expr					: val
						{
							$$ = create_node(NOTHING, EXPR, $1, NULL, NULL);
						}
						| val op expr
						{
							$$ = create_node(NOTHING, EXPR, $1, $2, $3);
						}
						;

val						:  ID_T
						{
							$$ = create_node($1, VAL_ID, NULL, NULL, NULL);
						}
						| BRA_T expr KET_T
						{
							$$ = create_node(NOTHING, VAL_BRACKETS, $2, NULL, NULL);
						}
						| MINUS_T const
						{
							$$ = create_node(NOTHING, VAL_NEGATIVE, $2, NULL, NULL);
						}
						|  const
						{
							$$ = create_node(NOTHING, VAL, $1, NULL, NULL);
						}


comp					: EQUAL_TO_T
						{
							$$ = create_node_characterArray("==", COMPARATOR_EQUAL_TO, NULL, NULL, NULL);
						}
						| NOT_EQUAL_T
						{
							$$ = create_node_characterArray("!=", COMPARATOR_NOT_EQUAL_TO, NULL, NULL, NULL);
						}
						| LESS_THAN_T
						{
							$$ = create_node_characterArray("<", COMPARATOR_LESS_THAN, NULL, NULL, NULL);
						}
						|  GREATER_THAN_T
						{
							$$ = create_node_characterArray(">", COMPARATOR_GREATER_THAN, NULL, NULL, NULL);
						}
						|  LESS_THAN_EQUAL_TO_T
						{
							$$ = create_node_characterArray("<=", COMPARATOR_LESS_THAN_EQUAL_TO, NULL, NULL, NULL);
						}
						|  GREATER_THAN_EQUAL_TO_T
						{
							$$ = create_node_characterArray(">=", COMPARATOR_GREATER_THAN_EQUAL_TO, NULL, NULL, NULL);
						}
						;
						

op						: ADD_T
						{
							$$ = create_node_characterArray("+", OP_ADD, NULL, NULL, NULL);
						}
						| MINUS_T
						{
							$$ = create_node_characterArray("-", OP_MINUS, NULL, NULL, NULL);
						}
						| MULTIPLY_T
						{
							$$ = create_node_characterArray("*", OP_MULTIPLY, NULL, NULL, NULL);
						}
						| DIVIDE_T
						{
							$$ = create_node_characterArray("/", OP_DIVIDE, NULL, NULL, NULL);
						}
						;
					

type					: INTEGER_T
						{
							$$ = create_node_characterArray("int", TYPE_INT, NULL, NULL, NULL);
						}
						| REAL_T
						{
							$$ = create_node_characterArray("float", TYPE_REAL, NULL, NULL, NULL);
						}
						| CHARACTER_T
						{
							$$ = create_node_characterArray("char", TYPE_CHARACTER, NULL, NULL, NULL);
						}
						;

const					: INTEGER_CONSTANT_T
						{
							$$ = create_node($1, CONST, NULL, NULL, NULL);
						}
						| REAL_CONSTANT_T
						{
							$$ = create_node($1, CONST, NULL, NULL, NULL);
						}
						| CHARACTER_CONSTANT_T
						{
							$$ = create_node($1, CONST, NULL, NULL, NULL);
						}
						;
%%

/* Code for routines for managing the Parse Tree */

TERNARY_TREE create_node_characterArray(char* ival,  int case_identifier, TERNARY_TREE p1, TERNARY_TREE  p2, TERNARY_TREE  p3){
	TERNARY_TREE t;
    t = (TERNARY_TREE)malloc(sizeof(TREE_NODE));
    t->cItem = ival ;
    t->nodeIdentifier = case_identifier;
    t->first = p1;
    t->second = p2;
    t->third = p3;
    return (t);
}

TERNARY_TREE create_node(int ival, int case_identifier, TERNARY_TREE p1, TERNARY_TREE  p2, TERNARY_TREE  p3){
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

int sizeofString(char *str){
	return str == NULL ? 0 : sizeof(str) - 1;
}

static int indent = 0;

void PrintTree(TERNARY_TREE t)
{

	if(t == NULL) return;

	

	int i;
	for(i = indent; i; i--){ printf(" ");}

	
		

		switch(t->nodeIdentifier)
		{
			for(i = indent; i; i--){ printf(" ");}
			case PROGRAM:
			{
				 printf("PROGRAM -> %s\n", symTab[t->item]->identifier);
				 break;
			}

			case BLOCK_DECLARATIONS:
			{
				printf(" TEST %s\n", symTab[t->item]->identifier);
				break;
			}
			case DECLARATIONS:
			{
				printf(" TEST %s\n", symTab[t->item]->identifier);
				break;
			}
			case STATEMENT_BLOCK:
			{
				//printf("STATEMENT_BLOCK\n");
				break;
			}
			case CONST:
			{
				

				printf(" Constant [%s] -> %s\n",symTab[t->item]->nodeType, symTab[t->item]->identifier);
				break;
			}

			default:
			{
				if(t->nodeIdentifier > 0 && t->nodeIdentifier < sizeof NodeName)
				{
					printf(" Node identifier -> %s\n", NodeName[t->nodeIdentifier]);
				}
				else
				{
					printf(" Unkown node identifier -> %d\n", t->nodeIdentifier);
				}

				if(t->item > 0 && symTab[t->item]->identifier && t->item < SYMTABSIZE)
				{
					printf("%4d\tl\t", indent);
					int j;
					for(j = indent; j; j--)
					{
						printf(" ");
					}
					printf("Identifier -> %s\n", symTab[t->item]->identifier);
				}
			}
		}
	
			indent +=2;
			PrintTree(t->first);
			indent +=2;
			PrintTree(t->second);
			indent +=2;
			PrintTree(t->third);
}
#endif

void WriteCode(TERNARY_TREE t)
{
	if(t == NULL)
	{
		return;
	}
	WriteCode(t->first);
	WriteCode(t->second);
	WriteCode(t->third);
}

/* Put other auxiliary functions here */

#include "lex.yy.c"