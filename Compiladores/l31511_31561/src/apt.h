typedef struct program program;
typedef struct declist declist;
typedef struct decl decl;
typedef struct stmlist stmlist;
typedef struct stm stm;
typedef struct exps exps;
typedef struct arglist arglist;
typedef struct arg arg;
typedef struct type type;


struct program
{
	declist *declist;
};

struct declist
{
	enum{ dec_empty, dec_declist } kind;

	union
	{
		struct
		{
			decl *dec;
		} dec_empty;
		struct
		{
			decl *dec;
         declist *declist;
		} dec_declist;

	} u;
};

struct decl
{
	enum{decl_id, decl_id_assign, decl_fun, decl_fun_arg, decl_define} kind;

	union
	{
		struct
		{
			char *id;
			type *t;

		} id;
		struct
		{
			char *id;
			type *t;
			exps *exps;
		} id_assign;
		struct
		{
			char *id;
			type *t;
			stmlist *stlist;
		} func;
		struct
		{
			char *id;
			type *t;
			stmlist *stlist;
			arglist *alist;
		} func_arg;
		struct
		{
			char *id;
			type *t;
		} def;
	} u;

};


struct stmlist
{
	enum{ stmlist_empty, stmlist_stm	} kind;

	union
	{
		struct
		{
			stm *s;
		   stmlist *slist;
		} st;

	} u;
};


struct stm
{
	enum{stm_decl, stm_exps, stm_if, stm_if_else, stm_while, stm_ret} kind;

	union
	{
		decl *d;
		exps *e;
		struct {
			exps *e;
			stmlist *stlist;
		} if_empty;
		struct {
			exps *e;
			stmlist *stlist1;
			stmlist *stlist2;
		} if_else;
		struct{
			exps *e;
			stmlist *stlist;
		} whl;

	} u;

};


struct exps
{
	enum{exps_id_assign, exps_id, exps_binop, exps_unop, exps_int, exps_float, exps_string, exps_boolean} kind;

	union
	{
		char *id;
		char *t;
		struct
		{
			char op[3];
			exps *arg1;
			exps *arg2;
		} binop;
		struct
		{
			char op[3];
			exps *arg1;
		} unop;
		struct {
			char *id;
			exps *rvalue;
		} id_assign;
	} u;

};

struct arglist
{
	enum{ arglist_empty, arglist_arg	} kind;

	union
	{
		struct
		{
			arg *ar;
		   arglist *arlist;
		} arg;

	} u;

};

struct arg
{
	exps *arg1;
	type *t;
};

struct type
{
	enum{type_intlit, type_floatlit, type_string, type_boolean} kind;

	union
	{
		char *str;
	} u;

};


program *program_new_declist(declist *declist);

declist *declist_new_empty(decl *d);
declist *declist_new_list(decl *d, declist *dlist);

decl *decl_new_id(char *id, type *t);
decl *decl_new_id_assign(char *id, type *t, exps *e);
decl *decl_new_func(char *id, stmlist *stlist, type *t);
decl *decl_new_func_arg(char *id, arglist *list, type *t, stmlist *stlist);
decl *decl_new_def(char *id, type *t);

stmlist *stmlist_new_empty(stm *st);
stmlist *stmlist_new_list(stm *st, stmlist *stlist);

stm *stm_new_decl(decl *d);
stm *stm_new_exps(exps *e);
stm *stm_new_if();
stm *stm_new_if_else();
stm *stm_new_while();
stm *stm_new_ret(exps *e);

exps *exps_new_id(char *id);
exps *exps_new_assign(char *id, exps *rvalue);
exps *exps_new_unop(char op[], exps *arg1);
exps *exps_new_binop(char op[], exps *arg1, exps *arg2);

type *new_type(char *c);

arglist *arglist_new_empty(arg *ar);
arglist *arglist_new_list(arg *ar, arglist *arlist);

arg *arg_new(exps *e, type *t);
