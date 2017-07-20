#include <stdlib.h>
#include <string.h>
#include "symboltable.h"


typedef struct symbolNode
{
   char *key;
   char *value;
   struct symbolNode *next;

} Node;


struct symboltable
{
   int size;
   Node *first;
};



symtable symtable_new()
{
   symtable stable;

   stable = malloc(sizeof(struct symboltable));

   stable->size = 0;
   stable->first = NULL;

   return stable;

}

void symtable_insert(char *key, char *value)
{

   Node *n;

   if (!symtable_contains(key)){

      n->key = malloc(strlen(key) + 1);

      if(n->key == NULL){
         free(n);
      }else{
         strcpy(n->key, key);

         n->value = value;
         n->next = stable->first;
         stable->first = n;
         stable->size++;
      }

   }

}

int symtable_contains(char *key)
{
   Node *current;

   for(current = stable->first; current != NULL; current = current->next){
      if(strcmp(key, current->key) == 0){
         return 1;
      }
   }
   return 0;

}

char *symtable_get(char *key)
{

   Node *current;

   for(current = stable->first; current != NULL; current = current->next){
      if(strcmp(key, current->key) == 0){
         return current->value;
      }
   }

}

char *symtable_remove(char *key)
{
   Node *previous;
   Node *current;
   char *value;

   for (current = stable->first, previous = NULL; current != NULL; previous = current, current = current->next){
      if(strcmp(key, current->key) == 0){
         value = current->value;


         if(previous == NULL){
            stable->first = stable->first->next;
         }else{
            previous->next = current->next;
         }

         free(current->key);
         free(current);
         stable->size--;
         return value;

      }
   }

}
