#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
   int info;
   nodo* sgte;
};

void push(nodo*&,int); //funcion insertar en la pila
int pop(nodo*&); //funcion quitar de la pila
int pedirdato();
char insertar3raposicion(nodo*&,int);
void verificarresultado(char);
void imprimirpila(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

   push (pila,1);
   push (pila,2);
   push (pila,3);
   push (pila,4);

   char opcion = insertar3raposicion(pila,pedirdato());

   verificarresultado(opcion);
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

int pedirdato(){
   int x;
   cout<<"\nIngrese un valor X: ";
   cin>>x;

   return x;
}

char insertar3raposicion(nodo*& pila,int info){
   if(pila == NULL || pila->sgte == NULL || pila->sgte->sgte == NULL){ //si no tiene 3 elementos
      return 'N';
   }

   nodo* p = new nodo();
   p->info = info;
   p->sgte = pila->sgte->sgte; //apuntar al nodo de la tercera posicion
   pila->sgte->sgte = p; //hacer que el segundo nodo apunte al nuevo

   return 'S';
}

void verificarresultado(char opcion){
   if(opcion == 'S'){
      cout<<"\nValor agregado correctamente";
   }
   else{
      cout<<"\nValor no agregado";
   }
   cout<<endl;

   return;
}

void imprimirpila(nodo*& pila){
   cout<<"\nImprimiendo pila\n\n";
   while(pila != NULL){
      cout<<pop(pila)<<" ";
   }
   cout<<endl;

   return;
}

/*
Dada una pila y un valor X colocar el vañor x en la tercera posicion se
la pila, retornando un parámetro con valor 'S' o 'N' según haya sido 
exitoso o no el requerimiento. (Definir parámetros y codificar).
*/