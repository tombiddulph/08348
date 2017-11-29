
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
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include <limits.h>


/* make forward declarations to avoid compiler warnings */
int yylex (void);
void yyerror (char *);
void yywarning (char *);

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
							FOR_STATEMENT, FOR_BLOCK, WRITE_BLOCK, CONDITIONAL, OUTPUT_BLOCK, OUTPUT_BLOCK_COMMA,
							 CONDITION, EXPR,
							VAL_ID, VAL_BRACKETS, VAL_NEGATIVE, VAL, COMPARATOR_EQUAL_TO,
							COMPARATOR_NOT_EQUAL_TO, COMPARATOR_LESS_THAN, COMPARATOR_GREATER_THAN,
							COMPARATOR_LESS_THAN_EQUAL_TO, COMPARATOR_GREATER_THAN_EQUAL_TO,
							OP_ADD, OP_MINUS, OP_MULTIPLY, OP_DIVIDE, TYPE_INT, TYPE_REAL, TYPE_CHARACTER,
							CONST_INT, CONST_REAL,CONST_CHARACTER, CONST, TYPE, STATEMENT, IDENTIFIER_BLOCK,
							DECLARATION, OP, COMPARATOR, IF_STATEMENT_ELSE_INNER, EXPR_INNER, FOR_BODY_INNER
						};

	char *NodeName[] =	{	
							"PROGRAM", "DECLARATIONS", "BLOCK_DECLARATIONS", "BLOCK", "STATEMENT_BLOCK", 
							"ASSIGNMENT_STATEMENT", "WRITE_STATEMENT", "READ_STATEMENT", "IF_STATEMENT", 
							"IF_STATEMENT_ELSE", "DO_STATEMENT", "WHILE_STATEMENT", "NEWLINE_STATEMENT", 
							"FOR_STATEMENT", "FOR_BLOCK", "WRITE_BLOCK", "CONDITIONAL", "OUTPUT_BLOCK", "OUTPUT_BLOCK_COMMA",
							 "CONDITION", "EXPR", 
							"VAL_ID", "VAL_BRACKETS", "VAL_NEGATIVE", "VAL", "COMPARATOR_EQUAL_TO", 
							"COMPARATOR_NOT_EQUAL_TO", "COMPARATOR_LESS_THAN", "COMPARATOR_GREATER_THAN", 
							"COMPARATOR_LESS_THAN_EQUAL_TO", "COMPARATOR_GREATER_THAN_EQUAL_TO", 
							"OP_ADD", "OP_MINUS", "OP_MULTIPLY", "OP_DIVIDE", "TYPE_INT", "TYPE_REAL", 
							"TYPE_CHARACTER", "CONST_INT", "CONST_REAL", "CONST_CHARACTER", "CONST", "TYPE"
							,"STATEMENT", "IDENTIFIER_BLOCK", "OP", "COMPARATOR", "DECLARATION", "IF_STATEMENT_ELSE_INNER"
							,"EXPR_INNER" , "FOR_BODY_INNER"
						};
	
		char* ReservedKeywords[] = {
				"auto",	"double",	"int",	"struct",
				"break",	"else",	"long",	"switch",
				"case",	"enum",	"register",	"typedef",
				"char",	"extern",	"return",	"union",
				"const",	"float",	"short",	"unsigned",
				"continue",	"for",	"signed",	"void",
				"default",	"goto",	"sizeof",	"volatile",
				"do",	"if",	"static",	"while"
		};
						
	 

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
    
	int item;
	char *cItem;
    int  nodeIdentifier;
    struct treeNode *first;
    struct treeNode *second;
	int assigned;
  };

typedef  struct treeNode TREE_NODE;
typedef  TREE_NODE       *BINARY_TREE;

/* ------------- forward declarations --------------------------- */

BINARY_TREE create_node(int,int,BINARY_TREE,BINARY_TREE);
BINARY_TREE create_node_characterArray(char*,int,BINARY_TREE,BINARY_TREE);
BINARY_TREE create_node_constant(int, char*, int, BINARY_TREE, BINARY_TREE);
void Print(BINARY_TREE t);
#ifdef DEBUG
	void PrintTree(BINARY_TREE ,int);
	int LineCount(BINARY_TREE);
	int LenCalc(int);
	int lineNumber = 0;
	int lineCount = 0;
	int offSet = 0;
	
	#define NEWLINE "\n"

#else
	
#define debug_print(a, args...) printf("\t\t%s(%s:%d) " a,  __func__,__FILE__, __LINE__, ##args)
#define debug_println(a, args...) debug_print(a "\n", ##args)


char lastType[20];
char *currentType;
int declarationWritten;
const char *GetCTypeFlag(char*, int);
void PrintComment(char *);  
int forLoopCount = 0;
const char *  programName;
void WriteCode(BINARY_TREE t);
int CheckIfConst(char * type);

void AssignTypes(BINARY_TREE t);

#endif	




/* ------------- symbol table definition --------------------------- */

struct symTabNode {
    char identifier[IDLENGTH];
	char *nodeType;
	int assigned;
	
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
    BINARY_TREE  tVal;
}

/* These are lexical tokens */

%token<iVal> ID_T BRA_T INTEGER_CONSTANT_T REAL_CONSTANT_T CHARACTER_CONSTANT_T  NOT_T


    
/* These tokens don't return a value */
%token 		COLON_T FULL_STOP_T ENDP_T SEMI_COLON_T  ASSIGNMENT_T EQUAL_TO_T 
			
			NOT_EQUAL_T LESS_THAN_EQUAL_TO_T LESS_THAN_T GREATER_THAN_EQUAL_TO_T 
			GREATER_THAN_T ADD_T MINUS_T MULTIPLY_T DIVIDE_T KET_T
			DECLARATIONS_T CODE_T OF_T TYPE_T CHARACTER_T INTEGER_T REAL_T
			IF_T THEN_T ELSE_T END_IF_T DO_T END_DO_T WHILE_T END_WHILE_T 
			 FOR_T END_FOR_T WRITE_T READ_T NEWLINE_T 
			 COMMA_T APOSTROPHE_T BY_T IS_T TO_T  OR_T AND_T



    

/* These rules return a type of tVal    */ 
 %type<tVal>  	program block declarations statement statement_block
				write_block conditional condition for_block output_block
				expr val comp op type const declaration identifier_block



%%

program             	: ID_T COLON_T block ENDP_T ID_T FULL_STOP_T
						{
						
							BINARY_TREE parseTree = create_node($1, PROGRAM, $3, NULL);

	
							
#ifdef DEBUG					
						LineCount(parseTree);
						
						PrintTree(parseTree, 1);
#else
						WriteCode(parseTree);
						
#endif							
						 
						
							
						}
						;
						
						
block					: DECLARATIONS_T declarations CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2, $4);
						}
						| CODE_T statement_block
						{
							$$ = create_node(NOTHING, BLOCK, $2,NULL);
						}
						;
						
						
						
declarations			: declaration
						{
							$$ = create_node(NOTHING, DECLARATIONS, $1, NULL);
						}
						| declaration declarations
						{
							$$ = create_node(NOTHING, DECLARATIONS, $1, $2);							
						}
						;

declaration				: identifier_block OF_T TYPE_T type SEMI_COLON_T
						{
							$$ = create_node_characterArray($4->cItem, DECLARATION, $1, $4);
						}
						;

identifier_block 		: identifier_block COMMA_T ID_T
						{
							$$ = create_node($3, IDENTIFIER_BLOCK, $1, NULL);
						}	
						| ID_T
						{
							$$ = create_node($1, IDENTIFIER_BLOCK, NULL, NULL);
						}			
						;
statement_block			: statement SEMI_COLON_T statement_block
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, $3);
						}
						| statement
						{
							$$ = create_node(NOTHING, STATEMENT_BLOCK, $1, NULL);
						}
						;
	
statement				: expr ASSIGNMENT_T ID_T
						{
							$$ = create_node($3, ASSIGNMENT_STATEMENT, $1, NULL);
						}
						|  write_block
						{
							$$ = create_node(NOTHING, WRITE_STATEMENT, $1, NULL);
						}
						| READ_T BRA_T ID_T KET_T
						{
							$$ = create_node($3, READ_STATEMENT, NULL, NULL);
						}
						| IF_T conditional THEN_T statement_block END_IF_T
						{
							$$ =  create_node(NOTHING, IF_STATEMENT, $2, $4);
						}
						| IF_T conditional THEN_T statement_block ELSE_T statement_block END_IF_T
						{
						   $$ = create_node(NOTHING, IF_STATEMENT_ELSE, $2, create_node(NOTHING, IF_STATEMENT_ELSE_INNER, $4, $6));
						}
						| DO_T statement_block WHILE_T conditional END_DO_T
						{
							$$ = create_node(NOTHING, DO_STATEMENT, $2, $4);
						}
						| WHILE_T conditional DO_T statement_block END_WHILE_T
						{
							$$ =  create_node(NOTHING, WHILE_STATEMENT, $2, $4);
						}
						| FOR_T for_block DO_T statement_block END_FOR_T
						{
							$$ = create_node(NOTHING, FOR_STATEMENT, $2, $4);
						}
						;

for_block				: ID_T IS_T expr BY_T expr TO_T expr 
						{
							$$ = create_node($1, FOR_BLOCK, $3, create_node(NOTHING, FOR_BLOCK, $5, $7));
						}						
						;

					
write_block				: NEWLINE_T
						{
							$$ = create_node(NOTHING, WRITE_BLOCK, NULL, NULL);
						}
						| WRITE_T BRA_T output_block KET_T
						{
							$$ = create_node(NOTHING, WRITE_BLOCK, $3, NULL);
						}
						;

output_block			: val
						{
							$$ = create_node(NOTHING, OUTPUT_BLOCK, $1, NULL);
						}
						| val COMMA_T output_block
						{
							$$ = create_node(NOTHING, OUTPUT_BLOCK, $1, $3);
						}
						
conditional				: condition
						{
							$$ = create_node(NOTHING, CONDITIONAL, $1, NULL);
						}
						|  condition AND_T conditional
						{
							$$ = create_node_characterArray("&&", CONDITIONAL, $1, $3);
						}
						| condition OR_T conditional
						{
							$$ = create_node_characterArray("||", CONDITIONAL, $1, $3);
						}
						;

condition				: NOT_T condition
						{
							$$ = create_node($1, CONDITION, $2, NULL);
						}
						| expr comp expr
						{
							$$ = create_node(NOTHING, CONDITION, $1, create_node(NOTHING, CONDITION, $2 ,$3));
						}
						;

expr					: val
						{
							$$ = create_node(NOTHING, EXPR, $1, NULL);
						}
						| val op expr
						{
					    	$$ = create_node(NOTHING, EXPR, $1, create_node(NOTHING, EXPR_INNER, $2, $3));
						}
						;

val						: ID_T
						{
							$$ = create_node($1, VAL_ID, NULL, NULL);
						}
						| BRA_T expr KET_T
						{
							$$ = create_node(NOTHING, VAL_BRACKETS, $2, NULL);
						}
						| MINUS_T const
						{
							$$ = create_node(NOTHING, VAL_NEGATIVE, $2, NULL);
						}
						|  const
						{
							$$ = create_node(NOTHING, VAL, $1, NULL);
						}


comp					: EQUAL_TO_T
						{
							$$ = create_node_characterArray("==", COMPARATOR, NULL, NULL);
						}
						| NOT_EQUAL_T
						{
							$$ = create_node_characterArray("!=", COMPARATOR, NULL, NULL);
						}
						| LESS_THAN_T
						{
							$$ = create_node_characterArray("<", COMPARATOR, NULL, NULL);
						}
						|  GREATER_THAN_T
						{
							$$ = create_node_characterArray(">", COMPARATOR, NULL, NULL);
						}
						|  LESS_THAN_EQUAL_TO_T
						{
							$$ = create_node_characterArray("<=", COMPARATOR, NULL, NULL);
						}
						|  GREATER_THAN_EQUAL_TO_T
						{
							$$ = create_node_characterArray(">=", COMPARATOR, NULL, NULL);
						}
						;
						

op						: ADD_T
						{
							$$ = create_node_characterArray("+", OP, NULL, NULL);
						}
						| MINUS_T
						{
							$$ = create_node_characterArray("-", OP, NULL, NULL);
						}
						| MULTIPLY_T
						{
							$$ = create_node_characterArray("*", OP, NULL, NULL);
						}
						| DIVIDE_T
						{
							$$ = create_node_characterArray("/", OP, NULL, NULL);
						}
						;
					

type					: INTEGER_T
						{
							$$ = create_node_characterArray("int", TYPE, NULL, NULL);
						}
						| REAL_T
						{
							$$ = create_node_characterArray("float", TYPE, NULL, NULL);
						}
						| CHARACTER_T
						{
							$$ = create_node_characterArray("char", TYPE, NULL, NULL);
						}
						;

const					: INTEGER_CONSTANT_T
						{
							$$ = create_node_constant($1,"int", CONST, NULL, NULL);
						}
						| REAL_CONSTANT_T
						{

							$$ = create_node_constant($1,"float", CONST, NULL, NULL);
						}
						| CHARACTER_CONSTANT_T
						{
							$$ = create_node_constant($1, "char", CONST, NULL, NULL);
						}
						;
%%

/* Code for routines for managing the Parse Tree */


BINARY_TREE create_node(int iVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	#ifndef DEBUG
	if(case_identifier == PROGRAM)
	{	
		programName = symTab[iVal]->identifier;
	}
	#endif
	
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->item = iVal;
	b->cItem = "EMPTY";
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	b->assigned = 0;

	return (b);
}


BINARY_TREE create_node_characterArray(char* iVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->item = 0;
	b->cItem = iVal;
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	b->assigned = 0;
	return (b);
}

BINARY_TREE create_node_constant(int iVal, char* cVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->item = iVal;
	b->cItem = cVal;
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	symTab[iVal]->nodeType = cVal;
	b->assigned = 0;
	return (b);
}



#define NodeType(t) (symTab[t->item]->nodeType)
#define Identifier(t)  (symTab[t->item]->identifier)
#define NodeIdentifier(t)  (NodeName[t->nodeIdentifier])

#ifdef DEBUG


int LenCalc(int x)
{
	 return x > 1000 ? 4 : x > 100 ? 3 : x > 10 ? 2 : 1;
}
		
		
int LineCount(BINARY_TREE t)
{
	
	if(t == NULL) 
	{
		offSet = LenCalc(lineCount);
		return lineCount;
	}
	
	++lineCount;
	LineCount(t->first);
	LineCount(t->second);
		
}


void PrintTree(BINARY_TREE t, int indent)
{
	
	if(t == NULL) return;
		
		printf("Line: %d  ", lineNumber++);
		
		int j = offSet - LenCalc(lineNumber);
		
			
		if(offSet - LenCalc(lineNumber) > 0)
		{
			printf("%*s", j , " ");
		}
		printf("|");
		
		int i;
		for(i = 0; i < indent; ++i) { printf("-"); }
		printf("\\ ");
		switch(t->nodeIdentifier)
		{
		
			case PROGRAM:
			{
				 printf("PROGRAM -> %s", Identifier(t));
				 break;
			}
			
			case CONDITION:
			{
				printf("Conditional -> %s", NodeIdentifier(t));
				break;
			}
			case COMPARATOR:
			{
					printf("Comparator -> [%s] %s",t->cItem, NodeIdentifier(t));
					break;
			}
			case CONST:
			{
				
				printf("Constant [%s] -> %s", NodeType(t), Identifier(t));
				break;
			}
			case TYPE:
			{
				printf("Type -> %s", t->cItem);
				break;
			}
			default:
			{
				if(t->nodeIdentifier >= 0 && t->nodeIdentifier < sizeof NodeName)
				{
					printf("Node identifier -> %s", NodeIdentifier(t));
					
				}
				else if(t->item > 0  && t->item < SYMTABSIZE)
				{
					printf("Identifier -> %s", Identifier(t));
				}
				else
				{
					printf("Unkown node identifier -> %d", t->nodeIdentifier);
					
				}
				
			}
		}
	
			printf("\n");
			PrintTree(t->first, ++indent);
			PrintTree(t->second, ++indent);
		
			
}			

#else

void AssignTypes(BINARY_TREE t)
{

	
	switch(t->nodeIdentifier)
	{
		case IDENTIFIER_BLOCK:
		{
			break;
		}
		case TYPE:
		{
			printf("TYPE %s", t->cItem);
			break;
		}
		default:
		{
			AssignTypes(t->first);
			AssignTypes(t->second);
		}
	}

	
}

void WriteCode(BINARY_TREE t)
{
	
	if(t == NULL)
	{
		return;
	}

	switch(t->nodeIdentifier)
	{
		case PROGRAM:
		{
			declarationWritten = 0;

			

			if(t->item < 0 || t->item > SYMTABSIZE)
			{
				printf("Unrecognised variable");
			}

			printf("\n/* Spl program name -> %s */\n", symTab[t->item]->identifier);
			printf("#include <stdio.h>\n");
			printf("int main(void) \n{\n\n");
			WriteCode(t->first);
			printf("\nreturn 0;\n}\n /* End program -> %s */\n", symTab[t->item]->identifier);
			return;
		}

		case BLOCK:
		{
			WriteCode(t->first);
			WriteCode(t->second);
			break;
		}
		case DECLARATIONS:
		{
			if(declarationWritten == 0)
			{
				PrintComment("declarations");
				declarationWritten = 1;
			}
			#ifdef CODEGENDEBUG
			 debug_println("Declarations first");
			#endif
			WriteCode(t->first);
			
			printf("\n");
			#ifdef CODEGENDEBUG
			 debug_println("Declarations second");
			#endif
			WriteCode(t->second);
			break;
		}
		case DECLARATION:
		{
			WriteCode(t->second);

			printf(" ");
			
			WriteCode(t->first);
		
			printf(";");
			break;
		}
		case STATEMENT_BLOCK:
		{
	
			WriteCode(t->first);
			WriteCode(t->second);
		
			break;
		}
		case READ_STATEMENT:
		{
			printf("scanf(\" %s&%s);\n", GetCTypeFlag(symTab[t->item]->nodeType, 1), symTab[t->item]->identifier);
			symTab[t->item]->assigned = 1;
			break;
		}
		case WRITE_STATEMENT:
		{
			WriteCode(t->first);
			break;
		}
		case ASSIGNMENT_STATEMENT:
		{
			
			if(strcmp(symTab[t->item]->nodeType, "NOTHING") == 0)
			{
				char buf[556];
				snprintf(buf, sizeof(buf), "%s%s", " attempting to assingn to undeclared identifier" , symTab[t->item]->identifier);
				printf("ERROR ");
				yyerror(buf);
				return;
			}
			
			strcpy(lastType, symTab[t->item]->nodeType);
			printf("%s = ", symTab[t->item]->identifier);
			
			
			
			if(t->first != NULL)
			{
				
				if(t->first->first != NULL)
				{
					
					if(t->first->first->nodeIdentifier)
					{
						
						int ident = t->first->first->nodeIdentifier;
						if(ident!= VAL && ident != VAL_NEGATIVE && ident != VAL_BRACKETS)
						{
							
							if((symTab[t->first->first->item]->nodeType) && strcmp(symTab[t->first->first->item]->nodeType, "NOTHING") == 0)
							{
								yyerror("undeclared variable");
							}
						}
					}
				}
			}

			
		
			

			symTab[t->item]->assigned = 1;
			t->assigned = 1;
			WriteCode(t->first);
			printf(";\n");
			break;
		}
		case OUTPUT_BLOCK:
		{
			
			
			printf("printf(");
			
			BINARY_TREE temp = t->second;
			if(temp!= NULL)
			{
				
				int count = 1;
				while(temp != NULL) 
				{			
					temp = temp->second;
					++count;
				}
					
				
				BINARY_TREE bTree = t->second;
				
				const char *formatFlags[count];
				const char *variables[count];
				

				short i;
				
			
				if(count == 2)
				{
					formatFlags[0] = GetCTypeFlag(symTab[t->first->first->item]->nodeType, 0);
					variables[0] = symTab[t->first->first->item]->identifier;
					formatFlags[1] = GetCTypeFlag(symTab[bTree->first->item]->nodeType, 0);
					variables[1] = symTab[bTree->first->item]->identifier;
				}
				else
				{
					for(i = 0; i < count; ++i)
					{
						if(i == 0)
						{
						
							formatFlags[i] = GetCTypeFlag(symTab[t->first->first->item]->nodeType, 0);
							variables[i] = symTab[t->first->first->item]->identifier;
						}
						else
						{
						
							formatFlags[i] = GetCTypeFlag(symTab[bTree->first->first->item]->nodeType, 0);
					   		variables[i] = symTab[bTree->first->first->item]->identifier;				
							bTree = bTree->second;
						}
					}
				}

			
				char *formatOutput = malloc(sizeof(formatFlags) + 1);
				char *variableOuput = malloc(sizeof(variables) + 1 + (1 * count));

				strcpy(formatOutput, formatFlags[0]);
				strcpy(variableOuput, variables[0]);
				for(i = 1; i < count; ++i)
				{
					strcat(formatOutput, formatFlags[i]);
					strcat(variableOuput, ",");
					strcat(variableOuput, variables[i]);
				}

				printf("\"%s\", %s);\n", formatOutput, variableOuput);
			

				free(formatOutput);
				free(variableOuput);
				
				break;
			}
			
		
			else if(t->first != NULL)
			{
				
				if(t->first->first != NULL)
				{
					
					int item = t->first->first->item;

					if(item > 0 && item < SYMTABSIZE)
					{				
						
						printf("\"%s", GetCTypeFlag(symTab[item]->nodeType, 1));	
					}
					
					if(t->first->first->first != NULL)
					{
						if(t->first->first->first->first != NULL)
						{
							printf("\"%s", GetCTypeFlag(symTab[t->first->first->first->first->item]->nodeType, 1));
						}
					}
					
					
				}
				
				else if(t->first != NULL)
				{
					
					int item = t->first->item;
					if(item > 0 && item < SYMTABSIZE)
					{
						
						printf("\"%s", GetCTypeFlag(symTab[t->first->item]->nodeType, 1));
					}
				
			
				}
				
			}
			
		
			WriteCode(t->first);
			
				
				
				if(t->first->nodeIdentifier == VAL_ID && symTab[t->first->item]->assigned == 0)
				{
					if(symTab[t->first->item]->assigned == 0)
					{
						yyerror("Attempting to print uninitalized variable");
					}
				}
				
			
			printf(");\n");
			
			
			WriteCode(t->second);
			break;
		}
		case WRITE_BLOCK:
		{
			if(t->first == NULL)  /* NEWLINE_T */
			{
				printf("printf(\"\\n\");\n");
			}
			else /* val COMMA_T write_block */ 
			{
				WriteCode(t->first);
				
			}
			break;
			
		}
		case IDENTIFIER_BLOCK:
		{	
		
			char * id = symTab[t->item]->identifier;
			
	
					
			

			if(t->item > currentSymTabSize || t->item < 0)
					{
						char buf[256];
						snprintf(buf, sizeof(buf), "%s %i", "Unkown identifier" , t->item);
						yyerror(buf);
					}
							
				
				
					if(strcmp(symTab[t->item]->nodeType,"NOTHING") == 0)
					{
						symTab[t->item]->nodeType = strncmp(currentType, "r", 1) == 0  ?  "f" : currentType ;
					}
					

			
			
					
					
					if(strcmp(id, programName) == 0) /* check variable names against the program name */
					{
						char buf[256];
						snprintf(buf, 
								sizeof(buf), 
								"%s%s", 
								"Identifier with the same name as the program are not allowed " , 
								programName); 
								
						yyerror(buf);
						return;
					}
					
					 int len, i;
					len = sizeof(ReservedKeywords)/sizeof(ReservedKeywords[0]);
					for( i = 0; i < len; ++i)
					{
						if(!strcmp(ReservedKeywords[i], id))
						{
							char buf[sizeof(id)+1];
							snprintf(buf, sizeof(buf), "%s%s", "_", id);
							strcpy(symTab[t->item]->identifier, buf);
							strcpy(id, buf);
							break;
						}
					}
					
					
					
							
					printf("%s", id);
					if(t->first != NULL)
					{
						printf(", ");
						WriteCode(t->first);
					}
			
				break;
		}

		case IF_STATEMENT:
		{
			printf("if(");
			WriteCode(t->first);
			printf(")\n{\n  ");
			WriteCode(t->second);
			printf("\n}\n");

			break;
		}
		case IF_STATEMENT_ELSE:
		{
			printf("if(");
			WriteCode(t->first);
			printf(")\n{\n");		
			WriteCode(t->second);
			break;
		}
		case IF_STATEMENT_ELSE_INNER:
		{
			WriteCode(t->first);
			printf("}\nelse \n{\n  ");
			WriteCode(t->second);
			printf("}\n");
			break;
		}
		case FOR_STATEMENT:
		{

			

			if(strcmp(symTab[t->first->item]->nodeType, "REAL_CONSTANT") == 0  || strcmp(symTab[t->first->item]->nodeType, "float") == 0)
			{
					
					yyerror("Floats are unspported as loop counters");
			}
			
			printf("register int by%d;\nfor(", ++forLoopCount);
			WriteCode(t->first);
			printf(")\n{\n");
			WriteCode(t->second);
			printf("}\n");
			break;
		}
		case FOR_BLOCK:
		{
			printf("%s = ", symTab[t->item]->identifier);
			t->assigned = 1;
			symTab[t->item]->assigned = 1;
			WriteCode(t->first);
			printf("; by%d = ", forLoopCount);
			WriteCode(t->second->first);
			printf(",((%s-(",symTab[t->item]->identifier);
			WriteCode(t->second->second);	
			printf(")) * (( by%d > 0 ) - ( by%d < 0 ))) <=0; %s += by%d", forLoopCount, forLoopCount, symTab[t->item]->identifier, forLoopCount);
			
			
			
			
			break;
		}
		case DO_STATEMENT:
		{
			printf("do\n{\n");
			WriteCode(t->first);
			printf("} while (");
			WriteCode(t->second);
			printf(");\n");
			break;
		}
		case WHILE_STATEMENT:
		{
			printf("while(");
			WriteCode(t->first);
			printf(")\n{\n");
			WriteCode(t->second);
			printf("}\n");
			break;
		}
      	
		case CONDITIONAL:
		{
			WriteCode(t->first);
			if(t->second != NULL)
			{
				printf(" %s ", t->cItem);
				WriteCode(t->second);
			}
			break;
		}
		
		case CONDITION:
		{
			if(t->item != NOTHING)
			{
				printf("!(");
				WriteCode(t->first);
				printf(")");
			}
			else
			{
				WriteCode(t->first);
				WriteCode(t->second->first);
				WriteCode(t->second->second);
			}
			break;
		}
		case VAL_ID:
		{
			printf("%s" ,symTab[t->item]->identifier);
			break;
		}
		case VAL_BRACKETS:
		{
			
			if(t->first->nodeIdentifier == EXPR && t->first->first->nodeIdentifier == VAL_ID && t->first->second->second == NULL)
			{
				printf("\"%s", GetCTypeFlag(symTab[t->first->first->item]->nodeType, 1));
				WriteCode(t->first->first);
				break;
			}

			printf("(");
			
			
			
			WriteCode(t->first);
			printf(")");
			break;
		}
		case VAL_NEGATIVE:
		{
			printf("-");
			WriteCode(t->first);
			break;
		}
		case EXPR:
		{
			
			WriteCode(t->first);
			WriteCode(t->second);	
			break;
		}
		case EXPR_INNER:
		{
			WriteCode(t->first);
			WriteCode(t->second);
			
			break;
		}
		case OP:
		case COMPARATOR:
		{
			printf(" %s ", t->cItem);
			break;
		}
		
		case VAL:
		{
			
			WriteCode(t->first);
			break;
		}
		case TYPE:
		{
			printf("%s ", t->cItem);
			
			currentType = &(t->cItem[0]);
			
			break;
		}
		case CONST:
		{

			if(CheckIfConst(lastType) == 1 &&  symTab[t->item]->identifier[0] !=  '\'')
			{
				if(strcmp(lastType, symTab[t->item]->nodeType) != 0)
				{
					if(strcmp(lastType, "float") == 0 && strcmp(symTab[t->item]->nodeType, "int") == 0)
					{
						char buf[100];
						snprintf(buf, sizeof(buf), "%s %s %s %s", "Attempt to a assign the value of a", symTab[t->item]->nodeType , "to a", lastType);
						yywarning(buf);

					}
					else
					{
						char buf[100];
						snprintf(buf, sizeof(buf), "%s %s %s %s", "Attempt to a assign the value of a",  symTab[t->item]->nodeType , "to a", lastType);
						yyerror(buf);
						return;
					}
				}
			}
			
			printf("%s", symTab[t->item]->identifier);
			
			break;
		}
		default:
		{
			WriteCode(t->first);
			WriteCode(t->second);
		}
	}

	
}


void PrintComment(char *comment)  
{ 
	printf("/* %s */\n",comment);
}

int CheckIfConst(char * type)
{
	if(strcmp(type, "int") == 0  || strcmp(type, "char") == 0 || strcmp(type, "float") == 0 )
	{
		return 1;
	}
	return 0;
}

const char *GetCTypeFlag(char *typeToken, int comma)
{
				if(strcmp(typeToken, "CHARACTER_CONSTANT") == 0  || strcmp(typeToken, "char") == 0)
				{
					return  comma == 1 ? "%c\", " : "%c";
				}
				else if(strcmp(typeToken, "INTEGER_CONSTANT") == 0  || strcmp(typeToken, "int") == 0)
				{
					return comma == 1 ? "%d\", " : "%d";
				}
				else if(strcmp(typeToken, "REAL_CONSTANT") == 0  || strcmp(typeToken, "float") == 0)
				{
					return comma == 1 ? "%g\", " : "%g";
					
				}
				else
				{
					char buf[256];
						snprintf(buf, 
								sizeof(buf), 
								"%s%s", 
								"unknown type token -> ", 
								typeToken); 
								
						yyerror(buf);
						return "ERROR";
				}
}


#endif
/* Put other auxiliary functions here */

#include "lex.yy.c"