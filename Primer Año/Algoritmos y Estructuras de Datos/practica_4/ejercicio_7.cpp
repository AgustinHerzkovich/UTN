#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
   int info;
   nodo* sgte;
};

void push(nodo*&,int); //funcion insertar en la pila
int pop(nodo*&); //funcion quitar de la pila
void ordenar(nodo*&);
void imprimirpila(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

   push (pila,5);
   push (pila,2);
   push (pila,7);
   push (pila,1);

   ordenar(pila);
   imprimirpila(pila);

   return 0;
}

void push(nodo*& pila,int info){
   nodo* p = new nodo(); //crear espacio en memoria para almacenar el nodo
   p->info = info; //cargar el valor dentro del nodo(dato)
   p->sgte = pila; //cargar el puntero pila dentro del nodo(*siguiente)
   pila = p; //asignar el nuevo nodo a pila

   return;
}

int pop(nodo*& pila){
   int x; //crear una variable x
   nodo* p = pila; //crear una variable auxiliar de tipo nodo
   x = pila->info; //conservar el valor del primer nodo
   pila = p->sgte; //avanzar con la pila un nodo
   delete p; //eliminar el nodo que estaba primero

   return x; //retornar la info que estaba en el primer nodo
}

void ordenar(nodo*& pila){
   nodo* aux=NULL;
   int comp;
   while(pila!=NULL){
      comp=pop(pila);
      while(aux!=NULL && aux->info > comp){
         push(pila,pop(aux));
      }
      push(aux,comp);
   }
   while(aux!=NULL){
      push(pila,pop(aux));
   }

   return;
}

void imprimirpila(nodo*& pila){
   cout<<"\nImprimiendo pila\n\n";
   while(pila != NULL){
      cout<<pop(pila)<<endl;
   }
   cout<<endl;

   return;
}

/*
Dada una pila desarrollar un procedimiento que ordene la misma de acuerdo al valor de sus nodos y la retorne. 
Solo se deben usar pilas. (Definir parámetros y codificar).
*/