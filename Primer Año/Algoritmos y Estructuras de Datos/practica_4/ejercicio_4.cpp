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
int pedirY();
void insertarfinal(nodo*&,int,int);
void imprimirpila(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

   push (pila,1);
   push (pila,4);
   push (pila,3);
   push (pila,4);

   int dato1 = pedirX();
   int dato2 = pedirY();
   insertarfinal(pila,dato1,dato2);
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
   cout<<"\nIngrese valor X: "; cin>>x;

   return x;
}
int pedirY(){
   int y;
   cout<<"\nIngrese valor Y: "; cin>>y;

   return y;
}

void insertarfinal(nodo*& pila,int x,int y){
   nodo* p = NULL; //pila auxiliar inicializada
   int dato; //variable auxiliar para no perder los datos

   while(pila!= NULL){ 
      dato = pop(pila); 
      if(dato==x){ //si el dato coincide con x
         push(p,y); //en lugar de guardar x guardo y
      }
      else{
         push(p,dato); //sino, guarda simplemente el dato
      }
   }

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
Dada una pila y dos valores X e Y, desarrollar un procedimiento que reemplace cada valor igual a X que 
se encuentre en la pila por el valor Y retornando la pila modificada. 
En caso de no haber ningún valor igual a X retornar la pila sin cambio. (Definir parámetros y codificar).
*/