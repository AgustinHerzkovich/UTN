#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

void queue(nodo*&,nodo*&,int); //funcion encolar
int unqueue(nodo*&,nodo*&); //funcion desencolar
void funcion(nodo*&,nodo*&);

int main(){
   
    nodo* frente = NULL; //inicializar el nodo frente
    nodo* fin = NULL; //inicializar el nodo fin 

    queue(frente,fin,1);
    queue(frente,fin,2);
    queue(frente,fin,3);
    queue(frente,fin,4);

    funcion(frente,fin);

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

void funcion(nodo*& frente,nodo*& fin){
    int n1,n2,dato;
    nodo* frenteaux = NULL;
    nodo* finaux = NULL;

    cout<<"\nIngrese dato 1 a eliminar: "; cin>>n1;
    cout<<"\nIngrese dato 2 a eliminar: "; cin>>n2;

    while(frente!=NULL){
        dato = unqueue(frente,fin);
        if(dato!=n1 && dato!=n2){
            queue(frenteaux,finaux,dato);
        }
    }

    while(frenteaux!=NULL){
        dato = unqueue(frenteaux,finaux);
        queue(frente,fin,dato);
    }

    cout<<"\n\nImprimiendo datos\n";
    while(frente!=NULL){
        cout<<unqueue(frente,fin)<<"  ";
    }

    return;
}

/*
Dada una cola (nodo = registro + puntero), desarrollar y codificar un 
procedimiento que elimine 2 nodos de la misma 
(indicar con un parámetro 'S'/'N' si ello fue‚ o no posible)
*/