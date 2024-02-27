#include <iostream>

using namespace std;

//1
struct nodo{
    int info;
    nodo* sgte;
};

//1.a)
nodo* listaSinOrden(nodo*& pila,nodo*& lista){
    nodo* listasinorden = NULL;
    while(pila!=NULL){
        push(listasinorden,pop(pila));
    }
    while(lista!=NULL){
        push(listasinorden,lista->info);
        lista = lista->sgte;
    }

    return listasinorden;
}

//1.b)
void listaOrdenada(nodo*& lista1,nodo*& lista2){
    nodo* lista3 = NULL;
    while(lista1!=NULL &&){
        insertarSinRepetir(lista3,lista1->info);
        lista1 = lista1->sgte;
    }
    while(lista2!=NULL){
        insertarSinRepetir(lista3,lista2->info);
        lista2 = lista2->sgte;
    }
    return;
}

//2
struct reservas{
    int codHotel,cantHabitaciones,cantDias;
};

struct infoLista{
    int codHotel,cantDias;
};

struct nodoLista{
    infoLista info;
    nodoLista* sgte;
};

int const tamaño = 100;

reservas vec[tamaño];

nodoLista* lista = NULL;

void ordenarVector(reservas vec[],int tamaño){
    int i,j;
    reservas aux;
    for(i=1;i<tamaño;i++){
        for(j=1;j<=tamaño-i;j++){
            if(vec[j-1].codHotel > vec[j].codHotel){
                aux = vec[j-1];
                vec[j-1] = vec[j];
                vec[j] = aux;
            }
        }
    }
};

void actualizarVector(reservas vec[],nodoLista* lista){
    nodoLista* aux = lista;
    int dato;
    while(aux!=NULL){
        dato = busquedaBinaria(vec,pop(aux),tamaño);
        if (dato>=0){
            vec[dato].cantDias -= aux->info.cantDias;
        }
    }
    
    return;
}