%{
#include <stdlib.h>
#include <string.h>
#include "apt.h"
#include "parser.h"
//atof
int bool(char *str){
   return *str == 't';
}
%}

INTLIT	[0-9]+
FLOATLIT [0-9]*\.[0-9]+([eE][\+\-]?[0-9]+)?
ID	[a-zA-Z][a-zA-Z0-9_]*
TYPE "int"|"float"|"string"|"boolean"|"void"
STRING \".*\"
BOOLEAN "true"|"false"

%%

{INTLIT}     { yylval.intlit = strdup(yytext); return INTLIT; }
{FLOATLIT}   { yylval.floatlit = strdup(yytext); return FLOATLIT; }
{BOOLEAN}    { yylval.boolean = strdup(yytext); return BOOL; }
{ID}         { yylval.id = strdup(yytext); return ID; }
{STRING}     { yylval.string = strdup(yytext); return STRING; }

"+"      { return ADD; }
"-"      { return SUB; }
"/"      { return DIV; }
"*"      { return MUL; }
"mod"    { return MOD; }
"^"      { return POW; }

"=="     { return EQUAL; }
"!="     { return NEQUAL; }
"="      { return ASSIGN; }
"<"      { return LESS; }
">"      { return GREAT; }
"<="     { return LESSEQUAL; }
">="     { return GREATEQUAL; }
"and"    { return AND; }
"or"     { return OR; }
"not"    { return NOT; }

\"      { return ASP; }
"("      { return LPAR; }
")"      { return RPAR; }
"["      { return LSQRPAR; }
"]"      { return RSQRPAR; }
"{"      { return LCHV; }
"}"      { return RCHV; }
","      { return CM; }
":"      { return SMCL; }

"define" { return DEF; }
"if"     { return IF; }
"then"   { return THEN; }
"else"   { return ELSE; }
"while"  { return WHILE; }
"do"     { return DO; }
"return" { return RET; }
"break"  { return BRK; }
"next"   { return NEXT; }


%%

int yywrap()  {return 1;}
