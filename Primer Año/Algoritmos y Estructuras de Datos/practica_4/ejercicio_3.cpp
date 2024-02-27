#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
   int info;
   nodo* sgte;
};

void push(nodo*&,int); //funcion insertar en la pila
int pop(nodo*&); //funcion quitar de la pila
int pedirvalor();
void insertarfinal(nodo*&,int);
void imprimirpila(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

   push (pila,1);
   push (pila,2);
   push (pila,3);
   push (pila,4);

   int valor = pedirvalor();
   insertarfinal(pila,valor);
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

int pedirvalor(){
   int x;
   cout<<"\nIngrese un valor X: "; cin>>x;

   return x;
}

void insertarfinal(nodo*& pila,int info){
   nodo* p = NULL; //pila auxiliar inicializada
   int dato; //variable auxiliar para no perder los datos

   while(pila!= NULL){ //mientras la pila tenga nodos
      dato = pop(pila); //guardo los datos
      push(p,dato); //y los almaceno en la pila auxiliar
   }

   push(pila,info); //almaceno como primer valor en la pila ya vacia, el nuevo dato ingresado por el usuario

   while(p!=NULL){ //mientras la pila auxiliar tenga nodos
      dato = pop(p); //guardo los datos
      push(pila,dato); //y los almaceno en la pila original
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
Dada una pila y un valor X, desarrollar un procedimiento que inserte el valor X 
en la última posición de la pila y la retorne. (Definir parámetros y codificar).
*/