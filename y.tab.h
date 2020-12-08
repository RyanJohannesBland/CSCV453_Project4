/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    CHARCON = 259,
    STRINGCON = 260,
    IF = 261,
    ELSE = 262,
    RETURN = 263,
    WHILE = 264,
    FOR = 265,
    VOID = 266,
    EXTERN = 267,
    CHAR = 268,
    INT = 269,
    INTCON = 270,
    STRING = 271,
    AND = 272,
    OR = 273,
    LT = 274,
    GT = 275,
    GTEQ = 276,
    LTEQ = 277,
    PLUS = 278,
    EQ = 279,
    NOTEQ = 280,
    MUL = 281,
    DIV = 282,
    NOT = 283,
    MINUS = 284
  };
#endif
/* Tokens.  */
#define ID 258
#define CHARCON 259
#define STRINGCON 260
#define IF 261
#define ELSE 262
#define RETURN 263
#define WHILE 264
#define FOR 265
#define VOID 266
#define EXTERN 267
#define CHAR 268
#define INT 269
#define INTCON 270
#define STRING 271
#define AND 272
#define OR 273
#define LT 274
#define GT 275
#define GTEQ 276
#define LTEQ 277
#define PLUS 278
#define EQ 279
#define NOTEQ 280
#define MUL 281
#define DIV 282
#define NOT 283
#define MINUS 284

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "parser.y"

    int intVal;
    char *charVal;
    struct idstruct *idVal;
    struct statement_node *statementNode;
    struct expr_node *expressionNode;
    struct assignment_node *assignmentNode;
    struct function_node *functionNode;
    struct parameter_node *parameterNode;

#line 126 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
