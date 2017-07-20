#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "apt.h"
#include "symboltable.h"
#include "semantica.h"


void check_declist(declist *dl)
{

   if(dl->kind == dec_empty)
   {
      check_decl(dl->u.dec_empty.dec);
   }
   else if(dl->kind == dec_declist)
   {
      check_decl(dl->u.dec_declist.dec);
      check_declist(dl->u.dec_declist.declist);
   }

}


type *check_decl(decl *dl)
{

   if(dl->kind == decl_id)
   {

      char *c = dl->u.id.id;
      type *tp = dl->u.id.t;

      if(symtable_contains(c))
      {
         printf("Variavel já declarada");
      }
      else
      {
         symtable_insert(c, tp->u.str);
      }

      return tp;

   }
   else if(dl->kind == decl_id_assign)
   {

      type *tp1 = dl->u.id_assign.t;
      type *tp2 = check_exps(dl->u.id_assign.exps);

      if( tp1->kind != tp2->kind)
      {
         printf("Valor errado para essa variavel\n");
         exit(1);
      }

   }

}



type *check_exps(exps *e)
{
  
    if(e->kind == exps_id_assign)
    {
      type *tp1;
      tp1->u.str = symtable_get(e->u.id_assign.id);
      type *tp2 = check_exps(e->u.id_assign.rvalue);
      
      if(tp1->kind != tp2->kind)
      {
         printf("Erro de valor\n");
         exit(1);
      }else{
         return tp1;
      }
   }
   else if(exps_int)
   {
      return new_type("int");
   }
   else if(exps_float)
   {
      return new_type("float");
   }
   else if(exps_string)
   {
      return new_type("string");
   }
   else if(exps_boolean)
   {
      return new_type("boolean");
   }

}


void check_stmlist(stmlist *slist)
{

   if(slist->kind == stmlist_empty)
   {
      check_stm(slist->u.st.s);
   }
   else if(slist->kind == stmlist_stm)
   {
      check_stm(slist->u.st.s);
      check_stmlist(slist->u.st.slist);
   }

}


type *check_stm(stm *s)
{

   if (s->kind == stm_decl)
   {
      return check_decl(s->u.d);

   } 
   else if(s->kind == stm_exps)
   {
      return check_exps(s->u.e);

   } 
   else if(s->kind == stm_if)
   {
      check_stmlist(s->u.if_empty.stlist);
      return check_exps(s->u.if_empty.e);

   } 
   else if(s->kind == stm_if_else)
   {
      check_stmlist(s->u.if_else.stlist1);
      check_stmlist(s->u.if_else.stlist2);

      return check_exps(s->u.if_empty.e);

   } 
   else if(s->kind == stm_while)
   {
      check_stmlist(s->u.whl.stlist);
      return check_exps(s->u.whl.e);

   } 
   else if(s->kind == stm_ret){
      return check_exps(s->u.e);

   }

}


void check_arglist(arglist *a)
{

   if(a->kind == arglist_empty)
   {
      check_arg(a->u.arg.ar);
   }
   else if(a->kind == arglist_arg)
   {
      check_arg(a->u.arg.ar);
      check_arglist(a->u.arg.arlist);
   }

}


type *check_arg(arg *a)
{

   type *t = check_exps(a->arg1);
   if(t->kind != a->t->kind)
   {
      printf("Erro no tipo do argumento\n");
   }
   else
   {
      return t;
   }

}
