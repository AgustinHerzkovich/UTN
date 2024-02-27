#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

void queue(nodo*&,nodo*&,int); //funcion encolar
int unqueue(nodo*&,nodo*&); //funcion desencolar

int main(){
   
    nodo* frente = NULL; //inicializar el nodo frente
    nodo* fin = NULL; //inicializar el nodo fin 

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