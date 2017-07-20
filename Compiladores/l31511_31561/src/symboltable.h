
typedef struct symboltable *symtable;

symtable stable;

symtable symtable_new();
void symtable_insert(char *key, char *value);
int symtable_contains(char *key);
char *symtable_get(char *key);
char*symtable_remove(char *key);
