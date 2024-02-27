#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
   int info;
   nodo* sgte;
};

void push(nodo*&,int); //funcion insertar en la pila
int pop(nodo*&); //funcion quitar de la pila
int pedirX();
int pedirI();
char introducirenpila(nodo*&,int,int);
void verificarresultado(char);
void imprimirpila(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

   push (pila,1);
   push (pila,2);
   push (pila,3);
   push (pila,4);

   int valor = pedirX();
   int posicion = pedirI();

   char resultado = introducirenpila(pila,valor,posicion);

   verificarresultado(resultado);
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

int pedirX(){
   int x;
   cout<<"\nIngrese un valor X: "; cin>>x;

   return x;
}

int pedirI(){
   int i;
   cout<<"\nIngrese un valor I: "; cin>>i;

   return i;
}

char introducirenpila(nodo*& pila,int info,int pos){
   int cont=1;
   if (pos<1){
      return 'N';
   }

   if (pos==1){
      push(pila,info);
   }

   nodo* p = pila;

   while(p!=NULL && cont < pos-1){
      p = p->sgte;
      cont++;
   }
   if(p==NULL){
      return 'N';
   }

   nodo* nuevo = new nodo();
   nuevo->info = info;
   nuevo->sgte = p->sgte;
   p->sgte = nuevo;

   return 'S';
}

void verificarresultado(char opcion){
   if(opcion == 'S'){
      cout<<"\nValor agregado correctamente";
   }
   else{
      cout<<"\nNo es posible agregar el valor";
   }
   cout<<endl;

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
Dada una pila y dos valores X e I, desarrollar un procedimiento que inserte el valor X 
en la posición I de la pila si es posible. (Definir parámetros y codificar).
*/