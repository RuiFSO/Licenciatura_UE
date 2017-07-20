#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "apt.h"

// #### PROGRAM ####
program *program_new_declist(declist *declist)
{
   program *ret = malloc (sizeof (program));
   ret->declist = declist;

   return ret;
}


// #### DECLIST ####
declist *declist_new_empty(decl *d)
{
   declist *ret = malloc (sizeof (declist));
   ret->kind = dec_empty;
   ret->u.dec_empty.dec = d;

   return ret;
}

declist *declist_new_list(decl *d, declist *dlist)
{
   declist *ret = malloc (sizeof (declist));
   ret->kind = dec_declist;
   ret->u.dec_declist.dec = d;
   ret->u.dec_declist.declist = dlist;

   return ret;
}


// #### DECL ####
decl *decl_new_id(char *id, type *t)
{
   decl *ret = malloc (sizeof (decl));
   ret->kind = decl_id;
   ret->u.id.id = id;
   ret->u.id.t = t;

   return ret;
}

decl *decl_new_id_assign(char *id, type *t, exps *e)
{
   decl *ret = malloc (sizeof (decl));
   ret->kind = decl_id_assign;
   ret->u.id_assign.id = id;
   ret->u.id_assign.exps = e;
   ret->u.id_assign.t = t;

   return ret;
}

decl *decl_new_func_arg(char *id, arglist *list, type *t, stmlist *stlist)
{
   decl *ret = malloc (sizeof (decl));
   ret->kind =  decl_fun_arg;
   ret->u.func_arg.id = id;
   ret->u.func_arg.t = t;
   ret->u.func_arg.stlist = stlist;
   ret->u.func_arg.alist = list;

   return ret;
}

decl *decl_new_func(char *id, stmlist *stlist, type *t)
{
   decl *ret = malloc (sizeof (decl));
   ret->kind = decl_fun;
   ret->u.func.id = id;
   ret->u.func.t = t;
   ret->u.func.stlist = stlist;

   return ret;
}

decl *decl_new_def(char *id, type *t)
{
   decl *ret = malloc (sizeof (decl));
   ret->kind = decl_define;
   ret->u.def.id = id;
   ret->u.def.t = t;

   return ret;
}


// #### ARGLIST ####
arglist *arglist_new_empty(arg *ar)
{
   arglist *ret = malloc (sizeof (arglist));
   ret->kind = arglist_empty;
   ret->u.arg.ar = ar;

   return ret;
}

arglist *arglist_new_list(arg *ar, arglist *arlist)
{
   arglist *ret = malloc (sizeof (arglist));
   ret->kind = arglist_arg;
   ret->u.arg.ar = ar;
   ret->u.arg.arlist = arlist;

   return ret;
}


// #### ARG ####
arg *arg_new(exps *e, type *t)
{
   arg *ret = malloc (sizeof (arg));

   ret->arg1 = e;
   ret->t = t;

   return ret;
}


// #### STMLIST ####
stmlist *stmlist_new_empty(stm *st)
{
   stmlist *ret = malloc (sizeof (stmlist));
   ret->kind = stmlist_empty;
   ret->u.st.s = st;

   return ret;
}

stmlist *stmlist_new_list(stm *st, stmlist *stlist)
{
   stmlist *ret = malloc (sizeof (stmlist));
   ret->kind = stmlist_stm;
   ret->u.st.s = st;
   ret->u.st.slist = stlist;

   return ret;
}


// #### STM ####
stm *stm_new_decl(decl *d)
{
   stm *ret = malloc(sizeof(stm));
   ret->kind = stm_decl;
   ret->u.d = d;

   return ret;
}

stm *stm_new_exps(exps *e)
{
   stm *ret = malloc(sizeof(stm));
   ret->kind = stm_exps;
   ret->u.e = e;

   return ret;
}

stm *stm_new_if()
{
   stm *ret = malloc(sizeof(stm));
   ret->kind = stm_if;


   return ret;
}

stm *stm_new_if_else()
{
   stm *ret = malloc(sizeof(stm));
   ret->kind = stm_if_else;

   return ret;
}

stm *stm_new_while()
{
   stm *ret = malloc(sizeof(stm));
   ret->kind = stm_while;

   return ret;
}

stm *stm_new_ret(exps *e)
{
   stm *ret = malloc(sizeof(stm));
   ret->kind = stm_ret;
   ret->u.e = e;

   return ret;
}


// #### EXPS ####
exps *exps_new_id(char *id)
{
   exps*ret = malloc (sizeof (exps));
   ret->kind = exps_id;
   ret->u.id = id;

   return ret;
}

exps *exps_new_assign(char *id, exps *rvalue)
{
   exps *ret = malloc(sizeof(exps));
   ret->kind = exps_id_assign;
   ret->u.id_assign.id = id;
   ret->u.id_assign.rvalue = rvalue;

   return ret;
}

exps *exps_new_unop(char op[], exps *arg1)
{
   exps *ret = malloc(sizeof(exps));
   ret->kind = exps_unop;
   strncpy(ret->u.binop.op, op, 2);
   ret->u.binop.arg1 = arg1;
   ret->u.binop.arg2 = NULL;

   return ret;
}

exps *exps_new_binop(char op[], exps *arg1, exps *arg2)
{
   exps *ret = malloc(sizeof(exps));
   ret->kind = exps_binop;
   strncpy(ret->u.binop.op, op, 2);
   ret->u.binop.arg1 = arg1;
   ret->u.binop.arg2 = arg2;

   return ret;
}


// #### TYPE #### //simplificar

type *new_type(char *c){

   if(c == "int"){
      type *ret = malloc (sizeof (type));
      ret->kind = type_intlit;
      ret->u.str = c;
      return ret;

   }else if(c == "string"){
      type *ret = malloc (sizeof (type));
      ret->kind = type_string;
      ret->u.str = c;
      return ret;

   }else if(c == "boolean"){
      type *ret = malloc (sizeof (type));
      ret->kind = type_boolean;
      ret->u.str = c;
      return ret;

   }else if (c == "float"){
      type *ret = malloc (sizeof (type));
      ret->kind = type_floatlit;
      ret->u.str = c;
      return ret;

   }

}

