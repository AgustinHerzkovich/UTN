#include <iostream>

using namespace std;

struct nodo{
   int info;
   nodo* sgte;
};

void rellenarLista(nodo*&);
int pop(nodo*&);
int cantidad(nodo*);
nodo* insertarOrdenado(nodo*&,int);

int main(){
    nodo* lista = NULL;
    rellenarLista(lista);
    cout<<"\nLa cantidad de nodos de la lista es: "<<cantidad(lista);

    return 0;
}

void rellenarLista(nodo*& lista){
    int i,n,dato;
    cout<<"\nIngrese cantidad de datos que desea ingresar a la lista: "; cin>>n;
    for(i=0;i<n;i++){
        cout<<"\nIngrese dato: "; cin>>dato;
        insertarOrdenado(lista,dato);
    }
    return;
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

int pop(nodo*& pila){
   int x; //crear una variable x
   nodo* p = pila; //crear una variable auxiliar de tipo nodo
   x = pila->info; //conservar el valor del primer nodo
   pila = p->sgte; //avanzar con la pila un nodo
   delete p; //eliminar el nodo que estaba primero

   return x; //retornar la info que estaba en el primer nodo
}

int cantidad(nodo* lista){
    int cont=0;
    nodo* listaaux = lista;
    while(listaaux != NULL){
        pop(listaaux);
        cont++;
    }

    return cont;
}

/*
Dada una lista (nodo = registro + puntero), desarrollar y codificar una función que devuelva la cantidad de nodos que tiene.
*/