#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
   int info;
   nodo* sgte;
};

void push(nodo*&,int); //funcion insertar en la pila
int pop(nodo*&); //funcion quitar de la pila
void inversa(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

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

void inversa(nodo*& pila){
   nodo* aux=NULL;
   while(pila!=NULL && pila->info!='.'){
      push(aux,pop(pila));
   }
   if (pila!=NULL)pop(pila);
   while (pila!=NULL&&aux!=NULL)
   {
      if (pila->info!=aux->info) return;
      pop(pila);
      pop(aux);
   }
}

/*
Definir una función INVERSA que evalúe dos conjuntos de caracteres separados por un punto y retorne True si los conjuntos son inversos 
(ej: ABcDe.eDcBA) o False si no lo son. Los conjuntos deben ingresarse por teclado. (Definir parámetros y codificar).
*/