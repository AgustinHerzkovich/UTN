#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

void queue(nodo*&,nodo*&,int); //funcion encolar
int unqueue(nodo*&,nodo*&); //funcion desencolar
void push(nodo*&,int); //funcion insertar en la pila
int pop(nodo*&); //funcion quitar de la pila
int contador(nodo*&,nodo*&);
void condicion(nodo*&,nodo*&,nodo*&,int);

int main(){
   
    nodo* frente = NULL; //inicializar el nodo frente
    nodo* fin = NULL; //inicializar el nodo fin 
    nodo* pila = NULL; //inicializar la pila

    queue(frente,fin,1);
    queue(frente,fin,2);
    queue(frente,fin,3);
    queue(frente,fin,4);

    int num = contador(frente,fin);
    condicion(frente,fin,pila,num);

    return 0;
}

void queue(nodo*& frente,nodo*& fin,int info){
    nodo* p = new nodo(); //crear espacio en memoria para almacenar un nodo
    p->info = info; //insertar la info en el nodo
    p->sgte = NULL; //apunta a null
    if(frente==NULL){ //si la cola esta vacia
        frente = p; //frente apunta al nuevo nodo
    }
    else{ //si no
        fin->sgte = p; //el fin apunta al ultimo nodo siempre
    }
    fin = p; //fin apunta al nuevo nodo

    return;
}

int unqueue(nodo*& frente,nodo*& fin){
    int x; //variable para almacenar el dato
    nodo* p = frente; //nodo auxiliar asignado al frente de la cola
    x = p->info; //obtener el valor del nodo
    frente = p->sgte;
    if(frente==NULL){ //si frente apunta a null
        fin = NULL; //fin apunta a null
    }
    delete p; //eliminar nodo auxiliar

    return x; //retonar el dato
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

int contador(nodo*& frente,nodo*& fin){
    int contador=0,dato;
    nodo* frenteaux = NULL;
    nodo* finaux = NULL;
    while(frente!=NULL){
        dato = unqueue(frente,fin);
        contador++;
        queue(frenteaux,finaux,dato);
    }

    while(frenteaux!=NULL){
        dato = unqueue(frenteaux,finaux);
        queue(frente,fin,dato);
    }

    return contador;
}

void condicion(nodo*& frente,nodo*& fin,nodo*& pila,int contador){
    if(contador>100){
        cout<<"\n\nImprimiendo cola en orden natural:\n";
        while(frente!=NULL){
            cout<<unqueue(frente,fin)<<"  ";
        }
    }
    else{
        cout<<"\n\nImprimiendo cola en orden inverso:\n";
        while(frente!=NULL){
            push(pila,unqueue(frente,fin));
        }

        while(pila!=NULL){
            cout<<pop(pila)<<"  ";
        }
    }

    return;
}

/*
Dada una cola (nodo = registro + puntero), imprimirla en orden natural 
si tiene más de 100 nodos, caso contrario imprimirla en orden inverso.
*/