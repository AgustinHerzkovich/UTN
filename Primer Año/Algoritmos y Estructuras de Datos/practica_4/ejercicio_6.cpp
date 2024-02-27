#include <iostream>
#include <stdlib.h>
#include <cstring>

using namespace std;

struct nodo{
   char info[20];
   nodo* sgte;
};

void push(nodo*&,char[]); //funcion insertar en la pila
char* pop(nodo*&); //funcion quitar de la pila
void procedimiento(nodo*&);

int main(){
   
   nodo* pila = NULL; //inicializar la pila

   procedimiento(pila);

   return 0;
}

void push(nodo*& pila,char info[]){
   nodo* p = new nodo(); //crear espacio en memoria para almacenar el nodo
   strcpy(p->info,info); //cargar el valor dentro del nodo(dato)
   p->sgte = pila; //cargar el puntero pila dentro del nodo(*siguiente)
   pila = p; //asignar el nuevo nodo a pila

   return;
}

char* pop(nodo*& pila){
   char *x = new char(); //crear una variable x que permanezca en la memoria
   nodo* p = pila; //crear una variable auxiliar de tipo nodo
   strcpy(x,pila->info); //conservar el valor del primer nodo
   pila = p->sgte; //avanzar con la pila un nodo
   delete p; //eliminar el nodo que estaba primero

   return x; //retornar la info que estaba en el primer nodo
}

void procedimiento(nodo*& pila){
   int cant,i;
   char nomyape[20],nomyapeaux[20];
   nodo* p = NULL;

   cout<<"\nIngrese cantidad de nombres y apellidos: "; cin>>cant;
   for(i=0;i<cant;i++){
      cout<<"\n\nNombre y apellido ["<<i+1<<"]: "; cin>>nomyape;
      push(pila,nomyape);
   }

   while(pila!=NULL){
      strcpy(nomyapeaux,pop(pila));
      push(p,nomyapeaux);
   }

   cout<<"\nImprimiendo pila\n\n";
   while(p != NULL){
      cout<<pop(p)<<endl;
   }
   cout<<endl;

   return;
}

/*
Desarrollar un procedimiento que ingrese por teclado un conjunto de Apellidos y Nombre de alumnos y los imprima en orden inverso al de ingreso. 
(Definir parámetros y codificar).
*/