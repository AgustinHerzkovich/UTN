#include <iostream>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

nodo* insertarOrdenado(nodo*&,int); //funcion insertar ordenado en la lista
nodo* buscar(nodo*,int); //funcion buscar en la lista
nodo* insertarSinRepetir(nodo*&,int); //funcion insertar sin repetir en la lista
int pop(nodo*&);
void mostrarLista(nodo*);
void apareo(nodo*&,nodo*&);

int main(){
    nodo* LISTA = NULL;
    nodo* LISTB = NULL;

    insertarOrdenado(LISTA,3);
    insertarOrdenado(LISTA,1);
    insertarOrdenado(LISTA,9);
    insertarOrdenado(LISTB,2);
    insertarOrdenado(LISTB,1);
    insertarOrdenado(LISTB,7);

    apareo(LISTA,LISTB);

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
    cout<<"\nImprimiendo lista apareada...\n";
    while(aux!=NULL){
        cout<<aux->info<<"  ";
        aux = aux->sgte;
    }
    return;
}

void apareo(nodo*& LISTA,nodo*& LISTB){
    nodo* LISTC = NULL;
    while(LISTA!=NULL){
        insertarSinRepetir(LISTC,pop(LISTA));
    }
    while(LISTB!=NULL){
        insertarSinRepetir(LISTC,pop(LISTB));
    }
    mostrarLista(LISTC);

    return;
}

/*
Dadas dos listas LISTA y LISTB (nodo = registro + puntero), desarrollar y codificar un procedimiento que genere otra lista LISTC por apareo del campo LEGAJO del 
registro (define orden creciente en ambas).
Nota: LISTA y LISTB dejan de ser útiles después del apareo).
*/