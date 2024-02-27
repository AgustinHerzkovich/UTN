#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

void queue(nodo*&,nodo*&,int); //funcion encolar
int unqueue(nodo*&,nodo*&); //funcion desencolar
void imprimir_cola(nodo*&,nodo*&);
int contador(nodo*&,nodo*&);

int main(){
   
    nodo* frente = NULL; //inicializar el nodo frente
    nodo* fin = NULL; //inicializar el nodo fin 

    queue(frente,fin,1);
    queue(frente,fin,2);
    queue(frente,fin,3);
    queue(frente,fin,4);

    imprimir_cola(frente,fin);
    cout<<"\nPosee "<<contador(frente,fin)<<" datos";

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

void imprimir_cola(nodo*& frente,nodo*& fin){
    int dato;
    nodo* frenteaux = NULL;
    nodo* finaux = NULL;

    cout<<"\nLa cola: \n";
    while(frente!=NULL){
        dato = unqueue(frente,fin);
        cout<<dato<<"  ";
        queue(frenteaux,finaux,dato);
    }

    while(frenteaux!=NULL){
        dato = unqueue(frenteaux,finaux);
        queue(frente,fin,dato);
    }

    return;
}

int contador(nodo*& frente,nodo*& fin){
    int contador=0;
    while(frente!=NULL){
        unqueue(frente,fin);
        contador++;
    }

    return contador;
}

/*Dada una cola (nodo = registro + puntero), desarrollar y 
codificar una función que devuelva la cantidad de nodos que tiene.
*/