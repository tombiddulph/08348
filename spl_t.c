
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 1 "spl.y"


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
							CONST_INT, CONST_REAL,CONST_CHARACTER, CONST, TYPE
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
							"TYPE_CHARACTER", "CONST_INT", "CONST_REAL", "CONST_CHARACTER", "CONST", "TYPE"
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
    union{
		int item;
		char *cItem;
	};
    int  nodeIdentifier;
    struct treeNode *first;
    struct treeNode *second;

  };

typedef  struct treeNode TREE_NODE;
typedef  TREE_NODE       *BINARY_TREE;

/* ------------- forward declarations --------------------------- */

BINARY_TREE create_node(int,int,BINARY_TREE,BINARY_TREE);
BINARY_TREE create_node_characterArray(char*,int,BINARY_TREE,BINARY_TREE);
void Print(BINARY_TREE t);
#ifdef DEBUG
	void PrintTree(BINARY_TREE t);
	int BufferSize(char *format, ...);
	#define NEWLINE "\n"
#endif	
void WriteCode(BINARY_TREE t);

/* ------------- symbol table definition --------------------------- */

struct symTabNode {
    char identifier[IDLENGTH];
	char *nodeType;
};

typedef  struct symTabNode SYMTABNODE;
typedef  SYMTABNODE        *SYMTABNODEPTR;

SYMTABNODEPTR  symTab[SYMTABSIZE]; 

int currentSymTabSize = 0;


/* Line 189 of yacc.c  */
#line 194 "spl_t.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID_T = 258,
     BRA_T = 259,
     INTEGER_CONSTANT_T = 260,
     REAL_CONSTANT_T = 261,
     CHARACTER_CONSTANT_T = 262,
     COLON_T = 263,
     FULL_STOP_T = 264,
     ENDP_T = 265,
     SEMI_COLON_T = 266,
     ASSIGNMENT_T = 267,
     EQUAL_TO_T = 268,
     NOT_EQUAL_T = 269,
     LESS_THAN_EQUAL_TO_T = 270,
     LESS_THAN_T = 271,
     GREATER_THAN_EQUAL_TO_T = 272,
     GREATER_THAN_T = 273,
     ADD_T = 274,
     MINUS_T = 275,
     MULTIPLY_T = 276,
     DIVIDE_T = 277,
     KET_T = 278,
     DECLARATIONS_T = 279,
     CODE_T = 280,
     OF_T = 281,
     TYPE_T = 282,
     CHARACTER_T = 283,
     INTEGER_T = 284,
     REAL_T = 285,
     IF_T = 286,
     THEN_T = 287,
     ELSE_T = 288,
     END_IF_T = 289,
     DO_T = 290,
     END_DO_T = 291,
     WHILE_T = 292,
     END_WHILE_T = 293,
     FOR_T = 294,
     END_FOR_T = 295,
     WRITE_T = 296,
     READ_T = 297,
     NEWLINE_T = 298,
     NOT_T = 299,
     COMMA_T = 300,
     APOSTROPHE_T = 301,
     BY_T = 302,
     IS_T = 303,
     TO_T = 304,
     OR_T = 305,
     AND_T = 306
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 214 of yacc.c  */
#line 126 "spl.y"

    int iVal;
    BINARY_TREE  tVal;



/* Line 214 of yacc.c  */
#line 288 "spl_t.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 300 "spl_t.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   113

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  16
/* YYNRULES -- Number of rules.  */
#define YYNRULES  48
/* YYNRULES -- Number of states.  */
#define YYNSTATES  107

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,    10,    15,    18,    24,    31,    35,    39,
      41,    45,    50,    55,    61,    69,    75,    81,    83,    88,
      97,    99,   103,   105,   108,   112,   116,   120,   122,   126,
     128,   132,   135,   137,   139,   141,   143,   145,   147,   149,
     151,   153,   155,   157,   159,   161,   163,   165,   167
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      53,     0,    -1,     3,     8,    54,    10,     3,     9,    -1,
      24,    55,    25,    56,    -1,    25,    56,    -1,     3,    26,
      27,    66,    11,    -1,     3,    26,    27,    66,    11,    55,
      -1,     3,    45,    55,    -1,    57,    11,    56,    -1,    57,
      -1,    62,    12,     3,    -1,    41,     4,    59,    23,    -1,
      42,     4,     3,    23,    -1,    31,    60,    32,    56,    34,
      -1,    31,    60,    32,    56,    33,    56,    34,    -1,    35,
      56,    37,    60,    36,    -1,    37,    60,    35,    56,    38,
      -1,    43,    -1,    39,    58,    56,    40,    -1,     3,    48,
      62,    47,    62,    49,    62,    35,    -1,    63,    -1,    63,
      45,    59,    -1,    61,    -1,    44,    60,    -1,    61,    51,
      60,    -1,    61,    50,    60,    -1,    62,    64,    62,    -1,
      63,    -1,    63,    65,    62,    -1,     3,    -1,     4,    62,
      23,    -1,    20,    67,    -1,    67,    -1,    13,    -1,    14,
      -1,    16,    -1,    18,    -1,    15,    -1,    17,    -1,    19,
      -1,    20,    -1,    21,    -1,    22,    -1,    29,    -1,    30,
      -1,    28,    -1,     5,    -1,     6,    -1,     7,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   160,   160,   175,   179,   187,   191,   195,   201,   205,
     211,   215,   219,   223,   227,   231,   235,   239,   243,   249,
     256,   260,   266,   270,   274,   278,   284,   290,   294,   300,
     304,   308,   312,   318,   322,   326,   330,   334,   338,   345,
     349,   353,   357,   364,   368,   372,   378,   382,   386
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID_T", "BRA_T", "INTEGER_CONSTANT_T",
  "REAL_CONSTANT_T", "CHARACTER_CONSTANT_T", "COLON_T", "FULL_STOP_T",
  "ENDP_T", "SEMI_COLON_T", "ASSIGNMENT_T", "EQUAL_TO_T", "NOT_EQUAL_T",
  "LESS_THAN_EQUAL_TO_T", "LESS_THAN_T", "GREATER_THAN_EQUAL_TO_T",
  "GREATER_THAN_T", "ADD_T", "MINUS_T", "MULTIPLY_T", "DIVIDE_T", "KET_T",
  "DECLARATIONS_T", "CODE_T", "OF_T", "TYPE_T", "CHARACTER_T", "INTEGER_T",
  "REAL_T", "IF_T", "THEN_T", "ELSE_T", "END_IF_T", "DO_T", "END_DO_T",
  "WHILE_T", "END_WHILE_T", "FOR_T", "END_FOR_T", "WRITE_T", "READ_T",
  "NEWLINE_T", "NOT_T", "COMMA_T", "APOSTROPHE_T", "BY_T", "IS_T", "TO_T",
  "OR_T", "AND_T", "$accept", "program", "block", "declarations",
  "statement_block", "statement", "for_block", "write_block",
  "conditional", "condition", "expr", "val", "comp", "op", "type", "const", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    52,    53,    54,    54,    55,    55,    55,    56,    56,
      57,    57,    57,    57,    57,    57,    57,    57,    57,    58,
      59,    59,    60,    60,    60,    60,    61,    62,    62,    63,
      63,    63,    63,    64,    64,    64,    64,    64,    64,    65,
      65,    65,    65,    66,    66,    66,    67,    67,    67
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     6,     4,     2,     5,     6,     3,     3,     1,
       3,     4,     4,     5,     7,     5,     5,     1,     4,     8,
       1,     3,     1,     2,     3,     3,     3,     1,     3,     1,
       3,     2,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     1,     0,     0,     0,     0,     0,
      29,     0,    46,    47,    48,     0,     0,     0,     0,     0,
       0,     0,    17,     4,     9,     0,    27,    32,     0,     0,
       0,     0,     0,    31,     0,     0,    22,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    39,    40,    41,    42,
       0,     0,     0,     7,     3,    30,    23,     0,     0,     0,
      33,    34,    37,    35,    38,    36,     0,     0,     0,     0,
       0,     0,    20,     0,     8,    10,    28,     2,    45,    43,
      44,     0,     0,    25,    24,    26,     0,     0,     0,    18,
      11,     0,    12,     5,     0,    13,    15,    16,     0,    21,
       6,     0,     0,    14,     0,     0,    19
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     7,     9,    23,    24,    41,    71,    35,    36,
      25,    26,    66,    50,    81,    27
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -35
static const yytype_int8 yypact[] =
{
       3,    16,    14,    13,   -35,    18,    29,    17,   -23,    15,
     -35,    70,   -35,   -35,   -35,    24,     6,    29,     6,    43,
      47,    50,   -35,   -35,    48,    55,    -3,   -35,    85,    42,
      18,    29,    68,   -35,     6,    57,    -8,    66,    58,    59,
      44,    29,    70,    93,    29,    94,   -35,   -35,   -35,   -35,
      70,    89,    33,   -35,   -35,   -35,   -35,    29,     6,     6,
     -35,   -35,   -35,   -35,   -35,   -35,    70,     6,    29,    70,
      60,    76,    56,    79,   -35,   -35,   -35,   -35,   -35,   -35,
     -35,    92,    52,   -35,   -35,   -35,    69,    71,    61,   -35,
     -35,    70,   -35,    18,    29,   -35,   -35,   -35,    70,   -35,
     -35,    72,    62,   -35,    70,    75,   -35
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -35,   -35,   -35,   -28,   -16,   -35,   -35,    21,   -14,   -35,
     -11,   -34,   -35,   -35,   -35,    98
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      32,    38,    53,    29,    39,    37,     1,    37,    72,    10,
      11,    12,    13,    14,     4,    54,    46,    47,    48,    49,
      56,     8,    30,    37,     3,    70,    15,    28,    74,    12,
      13,    14,    10,    11,    12,    13,    14,     5,     6,    76,
      31,    82,    58,    59,    83,    84,    40,    37,    37,    15,
      34,    42,    87,    86,    43,    85,    37,    72,    88,    44,
      16,    78,    79,    80,    17,   100,    18,    45,    19,    52,
      20,    21,    22,    10,    11,    12,    13,    14,   101,    60,
      61,    62,    63,    64,    65,    94,    95,   102,    51,    57,
      15,    55,    69,   105,    68,    67,    73,    75,    77,    90,
      89,    91,    92,    93,     0,    96,   103,     0,    98,    97,
     106,   104,    99,    33
};

static const yytype_int8 yycheck[] =
{
      11,    17,    30,    26,    18,    16,     3,    18,    42,     3,
       4,     5,     6,     7,     0,    31,    19,    20,    21,    22,
      34,     3,    45,    34,     8,    41,    20,    10,    44,     5,
       6,     7,     3,     4,     5,     6,     7,    24,    25,    50,
      25,    57,    50,    51,    58,    59,     3,    58,    59,    20,
      44,     4,    68,    67,     4,    66,    67,    91,    69,    11,
      31,    28,    29,    30,    35,    93,    37,    12,    39,    27,
      41,    42,    43,     3,     4,     5,     6,     7,    94,    13,
      14,    15,    16,    17,    18,    33,    34,    98,     3,    32,
      20,    23,    48,   104,    35,    37,     3,     3,     9,    23,
      40,    45,    23,    11,    -1,    36,    34,    -1,    47,    38,
      35,    49,    91,    15
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    53,     8,     0,    24,    25,    54,     3,    55,
       3,     4,     5,     6,     7,    20,    31,    35,    37,    39,
      41,    42,    43,    56,    57,    62,    63,    67,    10,    26,
      45,    25,    62,    67,    44,    60,    61,    62,    56,    60,
       3,    58,     4,     4,    11,    12,    19,    20,    21,    22,
      65,     3,    27,    55,    56,    23,    60,    32,    50,    51,
      13,    14,    15,    16,    17,    18,    64,    37,    35,    48,
      56,    59,    63,     3,    56,     3,    62,     9,    28,    29,
      30,    66,    56,    60,    60,    62,    60,    56,    62,    40,
      23,    45,    23,    11,    33,    34,    36,    38,    47,    59,
      55,    56,    62,    34,    49,    62,    35
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1455 of yacc.c  */
#line 161 "spl.y"
    {
							BINARY_TREE parseTree;
							parseTree = create_node((yyvsp[(1) - (6)].iVal), PROGRAM, (yyvsp[(3) - (6)].tVal), NULL);
							
#ifdef DEBUG							
							/*PrintTree(parseTree); */
#endif							
						/* WriteCode(parseTree); */
						Print(parseTree);
							
						;}
    break;

  case 3:

/* Line 1455 of yacc.c  */
#line 176 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, BLOCK_DECLARATIONS, (yyvsp[(2) - (4)].tVal), (yyvsp[(4) - (4)].tVal));
						;}
    break;

  case 4:

/* Line 1455 of yacc.c  */
#line 180 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, BLOCK, (yyvsp[(2) - (2)].tVal),NULL);
						;}
    break;

  case 5:

/* Line 1455 of yacc.c  */
#line 188 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (5)].iVal), DECLARATIONS, (yyvsp[(4) - (5)].tVal), NULL);
						;}
    break;

  case 6:

/* Line 1455 of yacc.c  */
#line 192 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, DECLARATIONS, (yyvsp[(4) - (6)].tVal), (yyvsp[(6) - (6)].tVal));							
						;}
    break;

  case 7:

/* Line 1455 of yacc.c  */
#line 196 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (3)].iVal), DECLARATIONS, (yyvsp[(3) - (3)].tVal), NULL);
						;}
    break;

  case 8:

/* Line 1455 of yacc.c  */
#line 202 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, STATEMENT_BLOCK, (yyvsp[(1) - (3)].tVal), (yyvsp[(3) - (3)].tVal));
						;}
    break;

  case 9:

/* Line 1455 of yacc.c  */
#line 206 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, STATEMENT_BLOCK, (yyvsp[(1) - (1)].tVal), NULL);
						;}
    break;

  case 10:

/* Line 1455 of yacc.c  */
#line 212 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(3) - (3)].iVal), ASSIGNMENT_STATEMENT, (yyvsp[(1) - (3)].tVal), NULL);
						;}
    break;

  case 11:

/* Line 1455 of yacc.c  */
#line 216 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, WRITE_STATEMENT, (yyvsp[(3) - (4)].tVal), NULL);
						;}
    break;

  case 12:

/* Line 1455 of yacc.c  */
#line 220 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(3) - (4)].iVal), READ_STATEMENT, NULL, NULL);
						;}
    break;

  case 13:

/* Line 1455 of yacc.c  */
#line 224 "spl.y"
    {
							(yyval.tVal) =  create_node(NOTHING, IF_STATEMENT, (yyvsp[(2) - (5)].tVal), (yyvsp[(4) - (5)].tVal));
						;}
    break;

  case 14:

/* Line 1455 of yacc.c  */
#line 228 "spl.y"
    {
						   (yyval.tVal) = create_node(NOTHING, IF_STATEMENT_ELSE, (yyvsp[(2) - (7)].tVal), create_node(NOTHING, IF_STATEMENT_ELSE, (yyvsp[(4) - (7)].tVal), (yyvsp[(6) - (7)].tVal)));
						;}
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 232 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, DO_STATEMENT, (yyvsp[(2) - (5)].tVal), (yyvsp[(4) - (5)].tVal));
						;}
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 236 "spl.y"
    {
							(yyval.tVal) =  create_node(NOTHING, WHILE_STATEMENT, (yyvsp[(2) - (5)].tVal), (yyvsp[(4) - (5)].tVal));
						;}
    break;

  case 17:

/* Line 1455 of yacc.c  */
#line 240 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, NEWLINE_STATEMENT, NULL, NULL);
						;}
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 244 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, FOR_STATEMENT, (yyvsp[(2) - (4)].tVal), (yyvsp[(3) - (4)].tVal));
						;}
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 250 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (8)].iVal), FOR_BODY, (yyvsp[(3) - (8)].tVal), create_node(NOTHING, FOR_BODY, (yyvsp[(5) - (8)].tVal), (yyvsp[(7) - (8)].tVal)));
						;}
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 257 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, WRITE_BLOCK, (yyvsp[(1) - (1)].tVal), NULL);
						;}
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 261 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, WRITE_BLOCK, (yyvsp[(1) - (3)].tVal), (yyvsp[(3) - (3)].tVal));
						;}
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 267 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, CONDITIONAL, (yyvsp[(1) - (1)].tVal), NULL);
						;}
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 271 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("!", CONDITIONAL_NOT, (yyvsp[(2) - (2)].tVal), NULL);
						;}
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 275 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("&&", CONDITIONAL_AND, (yyvsp[(1) - (3)].tVal), (yyvsp[(3) - (3)].tVal));
						;}
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 279 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("||", CONDITIONAL_OR, (yyvsp[(1) - (3)].tVal), (yyvsp[(3) - (3)].tVal));
						;}
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 285 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, CONDITION, (yyvsp[(1) - (3)].tVal), create_node(NOTHING, CONDITION, (yyvsp[(2) - (3)].tVal) ,(yyvsp[(3) - (3)].tVal)));
						;}
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 291 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, EXPR, (yyvsp[(1) - (1)].tVal), NULL);
						;}
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 295 "spl.y"
    {
					    	(yyval.tVal) = create_node(NOTHING, EXPR, (yyvsp[(1) - (3)].tVal), create_node(NOTHING, EXPR, (yyvsp[(2) - (3)].tVal), (yyvsp[(3) - (3)].tVal)));
						;}
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 301 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (1)].iVal), VAL_ID, NULL, NULL);
						;}
    break;

  case 30:

/* Line 1455 of yacc.c  */
#line 305 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, VAL_BRACKETS, (yyvsp[(2) - (3)].tVal), NULL);
						;}
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 309 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, VAL_NEGATIVE, (yyvsp[(2) - (2)].tVal), NULL);
						;}
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 313 "spl.y"
    {
							(yyval.tVal) = create_node(NOTHING, VAL, (yyvsp[(1) - (1)].tVal), NULL);
						;}
    break;

  case 33:

/* Line 1455 of yacc.c  */
#line 319 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("==", COMPARATOR_EQUAL_TO, NULL, NULL);
						;}
    break;

  case 34:

/* Line 1455 of yacc.c  */
#line 323 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("!=", COMPARATOR_NOT_EQUAL_TO, NULL, NULL);
						;}
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 327 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("<", COMPARATOR_LESS_THAN, NULL, NULL);
						;}
    break;

  case 36:

/* Line 1455 of yacc.c  */
#line 331 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray(">", COMPARATOR_GREATER_THAN, NULL, NULL);
						;}
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 335 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("<=", COMPARATOR_LESS_THAN_EQUAL_TO, NULL, NULL);
						;}
    break;

  case 38:

/* Line 1455 of yacc.c  */
#line 339 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray(">=", COMPARATOR_GREATER_THAN_EQUAL_TO, NULL, NULL);
						;}
    break;

  case 39:

/* Line 1455 of yacc.c  */
#line 346 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("+", OP_ADD, NULL, NULL);
						;}
    break;

  case 40:

/* Line 1455 of yacc.c  */
#line 350 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("-", OP_MINUS, NULL, NULL);
						;}
    break;

  case 41:

/* Line 1455 of yacc.c  */
#line 354 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("*", OP_MULTIPLY, NULL, NULL);
						;}
    break;

  case 42:

/* Line 1455 of yacc.c  */
#line 358 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("/", OP_DIVIDE, NULL, NULL);
						;}
    break;

  case 43:

/* Line 1455 of yacc.c  */
#line 365 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("int", TYPE, NULL, NULL);
						;}
    break;

  case 44:

/* Line 1455 of yacc.c  */
#line 369 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("float", TYPE, NULL, NULL);
						;}
    break;

  case 45:

/* Line 1455 of yacc.c  */
#line 373 "spl.y"
    {
							(yyval.tVal) = create_node_characterArray("char", TYPE, NULL, NULL);
						;}
    break;

  case 46:

/* Line 1455 of yacc.c  */
#line 379 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (1)].iVal), CONST, NULL, NULL);
						;}
    break;

  case 47:

/* Line 1455 of yacc.c  */
#line 383 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (1)].iVal), CONST, NULL, NULL);
						;}
    break;

  case 48:

/* Line 1455 of yacc.c  */
#line 387 "spl.y"
    {
							(yyval.tVal) = create_node((yyvsp[(1) - (1)].iVal), CONST, NULL, NULL);
						;}
    break;



/* Line 1455 of yacc.c  */
#line 2014 "spl_t.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1675 of yacc.c  */
#line 391 "spl.y"


/* Code for routines for managing the Parse Tree */


BINARY_TREE create_node(int iVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->item = iVal;
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	return (b);
}


BINARY_TREE create_node_characterArray(char* iVal, int case_identifier, BINARY_TREE b1, BINARY_TREE b2)
{
	BINARY_TREE b;
	b = (BINARY_TREE)malloc(sizeof(TREE_NODE));
	b->cItem = iVal;
	b->nodeIdentifier = case_identifier;
	b->first = b1;
	b->second = b2;
	return (b);
}



#define PrintComment(comment)  printf("/* %s */\n",comment);
#define NodeType(t) (symTab[t->item]->nodeType)
#define Identifier(t)  (symTab[t->item]->identifier)
#define NodeIdentifier(t)  (NodeName[t->nodeIdentifier])

#ifdef DEBUG

/*  function found here - https://stackoverflow.com/questions/3919995/determining-sprintf-buffer-size-whats-the-standard*/
int BufferSize(char *format, ...)
{
	va_list args;
	va_start(args, format);
	int result = vsnprintf(NULL, 0, format, args);
    va_end(args);
    return result + 1;
}

static int indent = 0;

void PrintTree(BINARY_TREE t)
{

	if(t == NULL) return;




	int i;

		for(i = indent; i; i--){ printf("| ");}
		switch(t->nodeIdentifier)
		{
		
			case PROGRAM:
			{

				 printf("PROGRAM -> %s\n", Identifier(t));


				 break;
			}

			case BLOCK_DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier);*/
				break;
			}
			case DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier);*/
				break;
			}
			case STATEMENT_BLOCK:
			{
				/* printf("STATEMENT_BLOCK\n"); */
				break;
			}
			case OP_ADD:
			case OP_DIVIDE:
			case OP_MINUS:
			case OP_MULTIPLY:
			{
				break;
			}
			case CONDITIONAL_AND:
			case CONDITIONAL_NOT:
			case CONDITIONAL_OR:
			{
				printf("Conditional -> %s\n", NodeIdentifier(t));
				break;
			}
			case COMPARATOR_EQUAL_TO:
			case COMPARATOR_NOT_EQUAL_TO:
			case COMPARATOR_LESS_THAN:
			case COMPARATOR_GREATER_THAN:
			case COMPARATOR_LESS_THAN_EQUAL_TO:
			case COMPARATOR_GREATER_THAN_EQUAL_TO:
			{
					printf("Comparator -> [%s] %s\n",t->cItem, NodeIdentifier(t));
					break;
			}
			case CONST:
			{
				
				printf(" Constant [%s] -> %s\n", NodeType(t), Identifier(t));
				break;
			}
			case VAL_ID:
			{
			  /*	printf(" Val Identifier %s of type %s\n",  symTab[t->item]->identifier, symTab[t->item]->nodeType); */
			 	break;
			 }
			case TYPE:
			{
				printf("Type -> %s\n ", t->cItem);
				break;
			}

			default:
			{
				if(t->nodeIdentifier >= 0 && t->nodeIdentifier < sizeof NodeName)
				{
					printf(" Node identifier -> %s\n", NodeIdentifier(t));
					
				}
				else
				{
					printf(" Unkown node identifier -> %d\n", t->nodeIdentifier);
					
				}


				if(t->item > 0  && t->item < SYMTABSIZE)

				{
					printf( "%3d   1\t", ++indent);
					for(i = indent; i; i--){ printf("| ");}
					printf("Identifier -> %s\n", Identifier(t));
				}
			}
		}
	
			++indent;
			PrintTree(t->first);
			PrintTree(t->second);
			/* PrintTree(t->third); */
			--indent;
}			
#endif

char depth[ 2056 ];
int di;


void Pop( )
{
    depth[ di -= 4 ] = 0;
}

void Push( char c )
{
   
}

void Print(BINARY_TREE t)
{
 
	if(t == NULL) return;

	switch(t->nodeIdentifier)
		{
		
			case PROGRAM:
			{

				 printf("PROGRAM -> %s\n", Identifier(t));


				 break;
			}

			case BLOCK_DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier); */
				break;
			}
			case DECLARATIONS:
			{
				/* printf(" TEST %s\n", symTab[t->item]->identifier); */
				break;
			}
			case STATEMENT_BLOCK:
			{
				/* printf("STATEMENT_BLOCK\n"); */
				break;
			}
			case OP_ADD:
			case OP_DIVIDE:
			case OP_MINUS:
			case OP_MULTIPLY:
			{
				break;
			}
			case CONDITIONAL_AND:
			case CONDITIONAL_NOT:
			case CONDITIONAL_OR:
			{
				printf("Conditional -> %s\n", NodeIdentifier(t));
				break;
			}
			case COMPARATOR_EQUAL_TO:
			case COMPARATOR_NOT_EQUAL_TO:
			case COMPARATOR_LESS_THAN:
			case COMPARATOR_GREATER_THAN:
			case COMPARATOR_LESS_THAN_EQUAL_TO:
			case COMPARATOR_GREATER_THAN_EQUAL_TO:
			{
					printf("Comparator -> [%s] %s\n",t->cItem, NodeIdentifier(t));
					break;
			}
			case CONST:
			{
				
				printf(" Constant [%s] -> %s\n", NodeType(t), Identifier(t));
				break;
			}
			/* case VAL_ID: */
			/* { */
			/* 	printf(" Val Identifier %s of type %s\n",  symTab[t->item]->identifier, symTab[t->item]->nodeType);*/
			/* 	break;*/
			/* }*/
			case TYPE:
			{
				printf("Type -> %s\n ", t->cItem);
				break;
			}

			default:
			{
				if(t->nodeIdentifier >= 0 && t->nodeIdentifier < sizeof NodeName)
				{
					printf(" Node identifier -> %s\n", NodeIdentifier(t));
					
				}
				else
				{
					printf(" Unkown node identifier -> %d\n", t->nodeIdentifier);
					
				}


				if(t->item > 0  && t->item < SYMTABSIZE)

				{
					/* printf( "%3d   1\t", ++indent);*/
					/* for(i = indent; i; i--){ printf("| ");}*/
					printf("Identifier -> %s\n", Identifier(t));
				}
			}
		}

	
	if(t->first)
	{
		printf( "%s `--", depth );
		
		Print(t->first);
		depth[ di++ ] = ' ';
    	depth[ di++ ] = '|' ;
    	depth[ di++ ] = ' ';
    	depth[ di++ ] = ' ';
    	depth[ di ] = 0;
		printf( "%s `--", depth );
		Push( ' ' );
	 	Print(t->second);
	 	depth[ di++ ] = ' ';
     	depth[ di++ ] = ' ';
     	depth[ di++ ] = ' ';
    	depth[ di++ ] = ' ';
    	depth[ di ] = 0;
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
			printf("/* Spl program name -> %s */\n", symTab[t->item]->identifier);
			printf("#include <stdio.h>\n");
			printf("int main(void) {\n\n");
			break;
		}

		case BLOCK:
		{
			PrintComment("code");
			WriteCode(t->first);
			break;
		}
		case BLOCK_DECLARATIONS:
		{
			PrintComment("declarations");
			WriteCode(t->first);
			PrintComment("code");
			WriteCode(t->second);
			break;
		}

		case WRITE_STATEMENT:
		{
			WriteCode(t->first);
			break;
		}
		case WRITE_BLOCK:
		{

			WriteCode(t->first);

			if(t->second) /* val COMMA_T write_block */
			{

			}
		}

		case VAL_ID:
		{
			break;
		}
		case VAL_BRACKETS:
		{
			break;
		}
		case VAL_NEGATIVE:
		{
			break;
		}
		case VAL:
		{
			break;
		}

		case CONST:
		{
			
		}
	}

	WriteCode(t->first);
	WriteCode(t->second);
	/* WriteCode(t->third); */
}

/* Put other auxiliary functions here */

#include "lex.yy.c"
