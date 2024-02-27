#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

void queue(nodo*&,nodo*&,int); //funcion encolar
int unqueue(nodo*&,nodo*&); //funcion desencolar
void unica_cola(nodo*&,nodo*&,nodo*&,nodo*&);

int main(){
   
    nodo* frenteA = NULL; //inicializar el nodo frente
    nodo* finA = NULL; //inicializar el nodo fin 
    nodo* frenteB = NULL; //inicializar el nodo frente
    nodo* finB = NULL; //inicializar el nodo fin 

    queue(frenteA,finA,1);
    queue(frenteA,finA,2);
    queue(frenteB,finB,3);
    queue(frenteB,finB,4);

    unica_cola(frenteA,finA,frenteB,finB);

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

void unica_cola(nodo*& frenteA,nodo*& finA,nodo*& frenteB,nodo*& finB){
    int dato;
    nodo* frenteAB = NULL;
    nodo* finAB = NULL;

    while(frenteA!=NULL){
        dato = unqueue(frenteA,finA);
        queue(frenteAB,finAB,dato);
    }

    while(frenteB!=NULL){
        dato = unqueue(frenteB,finB);
        queue(frenteAB,finAB,dato);
    }

    cout<<"\nCola final:\n";
    while(frenteAB!=NULL){
        cout<<unqueue(frenteAB,finAB)<<"  ";
    }

    return;
}

/*
Dadas dos colas COLA y COLB (nodo = registro + puntero), desarrollar y 
codificar un procedimiento que genere una única cola COLAB 
a partir de ellas. (Primero los nodos de COLA y luego los de COLB).
*/