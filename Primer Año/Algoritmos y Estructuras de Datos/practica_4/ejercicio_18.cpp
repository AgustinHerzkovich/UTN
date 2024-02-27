#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

nodo* insertarOrdenado(nodo*&,int);
nodo* insertarSinOrden(nodo*&,int);
void mostrarLista(nodo*);
int pop(nodo*&); //funcion quitar de la pila
void listac(nodo*,nodo*,nodo*&);

int main(){
   
    nodo* listaA = NULL; //inicializar lista
    nodo* listaB = NULL; //inicializar lista
    nodo* listaC = NULL; //inicializar lista

    insertarOrdenado(listaA,1);
    insertarOrdenado(listaA,5);
    insertarOrdenado(listaA,3);
    insertarOrdenado(listaB,6);
    insertarOrdenado(listaB,1);
    insertarOrdenado(listaB,9);

    listac(listaA,listaB,listaC);
    mostrarLista(listaC);

    return 0;
}

nodo* insertarOrdenado(nodo*& lista,int info){
    nodo* p = new nodo(); //crear nuevo nodo
    p->info = info; //insertar dato en el nodo
    p->sgte = NULL; //hacer que el nuevo nodo apunte a NULL
    if(lista == NULL || info < lista->info){ //si está vacía o si la info que se quiere agregar es menor a la que ya hay
        p->sgte = lista; //el nuevo nodo en el campo siguiente apunta a lista
        lista = p; //lista apunta a p
    }
    else{ //sino
        nodo* q = lista; //crea un nodo auxiliar que apunte a lista
        while(q->sgte != NULL && q->sgte->info < info){ //mientras haya datos y mientras el dato siguiente sea menor que el actual
            q = q->sgte; //avanzo con el auxiliar
        }
        p->sgte = q->sgte; //nuevo nodo siguiente apunta a auxiliar siguiente
        q->sgte = p; //auxiliar siguiente apunta a nuevo nodo
    }

    return p; //retorna p
}

nodo* insertarSinOrden(nodo*& lista,int info){
    nodo* p = new nodo(); 
    p->info = info; 
    p->sgte = NULL; 
    if(lista == NULL){ 
        p->sgte = lista; 
        lista = p; 
    }
    else{ //sino
        nodo* q = lista; 
        while(q->sgte != NULL){ 
            q = q->sgte; 
        }
        p->sgte = q->sgte; 
        q->sgte = p; 
    }

    return p; 
}

int pop(nodo*& pila){
   int x; //crear una variable x
   nodo* p = pila; //crear una variable auxiliar de tipo nodo
   x = pila->info; //conservar el valor del primer nodo
   pila = p->sgte; //avanzar con la pila un nodo
   delete p; //eliminar el nodo que estaba primero

   return x; //retornar la info que estaba en el primer nodo
}


void mostrarLista(nodo* lista){
    nodo* aux = lista;
    cout<<"\nImprimiendo lista...\n";
    while(aux!=NULL){
        cout<<aux->info<<"  ";
        aux = aux->sgte;
    }
    return;
}


void listac(nodo* listaA,nodo* listaB,nodo*& listaC){
    nodo* listaAaux = listaA;
    nodo* listaBaux = listaB;
    int dato;
    while(listaAaux !=NULL){
        dato = pop(listaAaux);
        insertarSinOrden(listaC,dato);
    }
    while(listaBaux!=NULL){
        dato=pop(listaBaux);
        insertarSinOrden(listaC,dato);
    }

    return;
}

/*
Dadas dos listas LISTA y LISTB (nodo = registro + puntero), desarrollar y codificar un procedimiento 
que genere una única lista LISTC a partir de ellas. (Primero los nodos de LISTA y luego los de LISTB).
*/