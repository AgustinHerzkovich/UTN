#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

nodo* insertarOrdenado(nodo*&,int); //funcion insertar ordenado en la lista
nodo* buscar(nodo*,int); //funcion buscar en la lista
nodo* insertarSinRepetir(nodo*&,int); //funcion insertar sin repetir en la lista
void mostrarLista(nodo*); //funcion mostrar lista
void eliminarNodo(nodo*&,int); //funcion eliminar nodo
void eliminarLista(nodo*&,int&); //funcion eliminar lista

int main(){
   
    nodo* lista = NULL; //inicializar lista

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

nodo* buscar(nodo* lista, int buscado){
    nodo* aux = lista; //nodo auxiliar para recorrer la lista
    while(aux!=NULL && aux->info != buscado){ //avanzo mientras haya datos y mientras la info no coincida
        aux = aux->sgte; //avanzo con aux
    }

    return aux; //retorna la direccion del nodo que contiene la info buscada, o NULL si no la encontró
}

nodo* insertarSinRepetir(nodo*& lista,int info){
    nodo* encontro = buscar(lista,info); //nodo para saber si encontró el dato
    if(encontro == NULL){ //si no lo encontró
        encontro = insertarOrdenado(lista,info); //lo agrega a la lista
    }

    return encontro; //retorno lo que encontró
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

void eliminarNodo(nodo*& lista,int dato){
    if(lista!=NULL){
        nodo* aux_borrar = lista;
        nodo* anterior = NULL;
        while(aux_borrar != NULL && aux_borrar->info != dato){
            anterior = aux_borrar;
            aux_borrar = aux_borrar->sgte;
        }
        if(aux_borrar == NULL){
            cout<<"\nEl elemento no existe";
        }
        else if(anterior == NULL){
            lista = lista->sgte;
            delete aux_borrar;
        }
        else{
            anterior->sgte = aux_borrar->sgte;
            delete aux_borrar;
        }
    }
    return;
}

void eliminarLista(nodo*& lista,int& n){ //ejecutar en un bucle para eliminar todos los elementos
    nodo* aux = lista;
    n = aux->info;
    lista = aux->sgte;
    delete aux;
    return;
}