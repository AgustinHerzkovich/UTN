#include <iostream>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

nodo* insertarOrdenado(nodo*&,int);
nodo* insertarDesordenado(nodo*&,int);
int pop(nodo*&); //funcion quitar de la pila
void mostrarLista(nodo*);
int contador(nodo*);
void condicion(int,nodo*);

int main(){
    nodo* lista = NULL;

    insertarOrdenado(lista,1);
    insertarOrdenado(lista,2);
    insertarOrdenado(lista,3);

    int cantnodos = contador(lista);
    condicion(cantnodos,lista);

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

nodo* insertarDesordenado(nodo*& lista,int info){
    nodo* p = new nodo(); //crear nuevo nodo
    p->info = info; //insertar dato en el nodo
    p->sgte = NULL; //hacer que el nuevo nodo apunte a NULL
    if(lista == NULL || info > lista->info){ //si está vacía o si la info que se quiere agregar es menor a la que ya hay
        p->sgte = lista; //el nuevo nodo en el campo siguiente apunta a lista
        lista = p; //lista apunta a p
    }
    else{ //sino
        nodo* q = lista; //crea un nodo auxiliar que apunte a lista
        while(q->sgte != NULL && q->sgte->info > info){ //mientras haya datos y mientras el dato siguiente sea menor que el actual
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

void mostrarLista(nodo* lista){
    nodo* aux = lista;
    cout<<"\nImprimiendo lista...\n";
    while(aux!=NULL){
        cout<<aux->info<<"  ";
        aux = aux->sgte;
    }
    return;
}

int contador(nodo* lista){
    nodo* aux = lista;
    int cont=0;
    while(aux!=NULL){
        aux = aux->sgte;
        cont++;
    }

    return cont;
}

void condicion(int cant,nodo* lista){
    nodo* aux1 = lista;
    nodo* aux2 = NULL;
    if(cant>100){
        cout<<"\nORDEN NATURAL\n";
        mostrarLista(lista);
    }
    else{
        cout<<"\nORDEN INVERSO\n";
        while(aux1!=NULL){
            insertarDesordenado(aux2,pop(aux1));
        }
        mostrarLista(aux2);
    }

    return;
}


/*
Dada una LISTA (nodo = registro + puntero), imprimirla en orden natural si tiene más de 100 nodos, caso contrario imprimiría en orden inverso.
*/