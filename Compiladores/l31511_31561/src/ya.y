%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "apt.h"
#include "symboltable.h"
#include "semant.h"

int yylex (void);
void yyerror (char const *);

FILE *yyin;

%}

%union {

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
}

/* Bison declarations.  */
%left    SMCL

%token   <intlit>    INTLIT BOOL
%token   <floatlit>  FLOATLIT
%token   <string>    STRING
%token   <id>        ID
%token               VOID
%token               DEF IF THEN ELSE WHILE DO RET BRK NEXT

%right		ASSIGN
%left       OR
%left       AND
%left       NOT
%nonassoc   LESS GREAT EQUAL NEQUAL LESSEQUAL GREATEQUAL

%left			SUB ADD
%left			MUL DIV MOD
%left			NEG     /* negation--unary minus */
%right      POW

%token      LPAR RPAR ASP LCHV RCHV LSQRPAR RSQRPAR CM

%type <program>   program
%type <arg>       arg
%type <arglist>   arglist
%type	<stm>       stm
%type <stmlist>   stmlist
%type <decl>      decl
%type <declist>   declist
%type <exps>      exps
%type <type>      type
%%

program: declist { printf("Produção: program");}
;

declist: decl SMCL { $$ = declist_new_empty($1); }
       | decl SMCL declist { $$ = declist_new_list($1, $3); }

;

decl: ID SMCL type   { $$ = decl_new_id($1, $3); }
    | ID SMCL type ASSIGN exps  { $$ = decl_new_id_assign($1, $3, $5); }
    | ID LPAR RPAR SMCL type LCHV stmlist RCHV   { $$ = decl_new_func($1, $7, $5); }
    | ID LPAR arglist RPAR SMCL type LCHV stmlist RCHV { $$ = decl_new_func_arg($1, $3, $6, $8); }
    | DEF ID type { $$ = decl_new_def($2, $3); }
;

stmlist: stm SMCL          { $$ = stmlist_new_empty($1); }
       | stm SMCL stmlist  { $$ = stmlist_new_list($1, $3); }
;

stm: decl         { $$ = stm_new_decl($1); }
   | exps         { $$ = stm_new_exps($1); }
   | IF BOOL THEN LCHV stmlist RCHV  { $$ = stm_new_if(); }
   | IF BOOL THEN LCHV stmlist RCHV ELSE LCHV stmlist RCHV { $$ = stm_new_if_else(); }
   | WHILE BOOL DO LCHV stmlist RCHV { $$ = stm_new_while(); }
   | RET exps      { $$ = stm_new_ret($2); }
;

exps: ID ASSIGN exps { $$ = exps_new_assign($1, $3); }
   | ID  { $$ = exps_new_id($1); }
   | exps SUB exps  { $$ = exps_new_binop("-", $1, $3); }
   | exps ADD exps  { $$ = exps_new_binop("+", $1, $3); }
   | exps MUL exps  { $$ = exps_new_binop("*", $1, $3); }
   | exps DIV exps  { $$ = exps_new_binop("/", $1, $3); }
   | exps MOD exps  { $$ = exps_new_binop("mod", $1, $3); }
   | SUB exps  %prec NEG  { $$ = exps_new_unop("-", $2); }
   | LPAR exps RPAR  { $$ = $2; }
   | exps POW exps  { $$ = exps_new_binop("^", $1, $3); }
   | exps EQUAL exps {$$ = exps_new_binop("==", $1, $3);}
   | exps NEQUAL exps {$$ = exps_new_binop("!=", $1, $3);}
   | exps LESS exps {$$ = exps_new_binop("<", $1, $3);}
   | exps GREAT exps {$$ = exps_new_binop(">", $1, $3);}
   | exps LESSEQUAL exps {$$ = exps_new_binop("<=", $1, $3);}
   | exps GREATEQUAL exps {$$ = exps_new_binop(">=", $1, $3);}
   | exps AND exps {$$ = exps_new_binop("&&", $1, $3);}
   | exps OR exps {$$ = exps_new_binop("||", $1, $3);}
   | NOT exps  {$$ = exps_new_unop("not", $2);}
   | type   { }
;

arglist: arg { $$ = arglist_new_empty($1); }
       | arg CM arglist { $$ = arglist_new_list($1, $3); }
;

arg: exps SMCL type { $$ = arg_new($1, $3); }
;

type:  INTLIT    { $$ = new_type($1); }
    | FLOATLIT  { $$ = new_type($1); }
    | BOOL      { $$ = new_type($1); }
    | STRING    { $$ = new_type($1); }
;
%%

/* Called by yyparse on error.  */

void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}

int main (argc, argv)
int argc;
char **argv;
{
   if(argc > 1){
      if(!(yyin = fopen(argv[1], "r"))) {
         perror(argv[1]);
         return (1);
      }
   }
   do{
      yyparse();
   } while(!feof(yyin));

}
