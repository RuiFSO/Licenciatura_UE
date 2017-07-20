/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
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
    SMCL = 258,
    INTLIT = 259,
    BOOL = 260,
    FLOATLIT = 261,
    STRING = 262,
    ID = 263,
    VOID = 264,
    DEF = 265,
    IF = 266,
    THEN = 267,
    ELSE = 268,
    WHILE = 269,
    DO = 270,
    RET = 271,
    BRK = 272,
    NEXT = 273,
    ASSIGN = 274,
    OR = 275,
    AND = 276,
    NOT = 277,
    LESS = 278,
    GREAT = 279,
    EQUAL = 280,
    NEQUAL = 281,
    LESSEQUAL = 282,
    GREATEQUAL = 283,
    SUB = 284,
    ADD = 285,
    MUL = 286,
    DIV = 287,
    MOD = 288,
    NEG = 289,
    POW = 290,
    LPAR = 291,
    RPAR = 292,
    ASP = 293,
    LCHV = 294,
    RCHV = 295,
    LSQRPAR = 296,
    RSQRPAR = 297,
    CM = 298
  };
#endif
/* Tokens.  */
#define SMCL 258
#define INTLIT 259
#define BOOL 260
#define FLOATLIT 261
#define STRING 262
#define ID 263
#define VOID 264
#define DEF 265
#define IF 266
#define THEN 267
#define ELSE 268
#define WHILE 269
#define DO 270
#define RET 271
#define BRK 272
#define NEXT 273
#define ASSIGN 274
#define OR 275
#define AND 276
#define NOT 277
#define LESS 278
#define GREAT 279
#define EQUAL 280
#define NEQUAL 281
#define LESSEQUAL 282
#define GREATEQUAL 283
#define SUB 284
#define ADD 285
#define MUL 286
#define DIV 287
#define MOD 288
#define NEG 289
#define POW 290
#define LPAR 291
#define RPAR 292
#define ASP 293
#define LCHV 294
#define RCHV 295
#define LSQRPAR 296
#define RSQRPAR 297
#define CM 298

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 16 "ya.y" /* yacc.c:1909  */


   char *intlit;
   char *floatlit;
   char *boolean;
   char *string;
   char *id;

   program *program;
   arg *arg;
   arglist *arglist;
   decl *decl;
   declist *declist;
   stm *stm;
	stmlist *stmlist;
   exps *exps;
   type *type;

#line 159 "parser.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_H_INCLUDED  */
