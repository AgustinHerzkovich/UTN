#include <iostream>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

struct cola{
    nodo* frente;
    nodo* fin;
};

int pedirnum();
void inicializacion(int,cola[]);
void queue(nodo*&,nodo*&,int);
int unqueue(nodo*&,nodo*&);
nodo* insertarOrdenado(nodo*&,int);
nodo* buscar(nodo*,int);
nodo* insertarSinRepetir(nodo*&,int);
void apareo(cola[],nodo*&,int);
void mostrarCola(nodo*);

int main(){

    nodo* c0la = NULL;

    int tam = pedirnum();
    cola vec[tam];
    inicializacion(tam,vec);
    apareo(vec,c0la,tam);
    mostrarCola(c0la);

    return 0;
}

int pedirnum(){
    int n;
    cout<<"\nIngrese tamaño de vector (N<30): "; cin>>n;
    while(n>=30){
        cout<<"\nIngrese tamaño de vector (N<30): "; cin>>n;
    }

    return n;
}

void inicializacion(int n,cola vec[]){
    int i,dato,m,j;
    for(i=0;i<n;i++){
        vec[i].frente = NULL;
        vec[i].fin = NULL;
    }

    for(i=0;i<n;i++){
        cout<<"\nIngrese cantidad de datos de la cola "<<i+1<<": "; cin>>m;
        for(j=0;j<m;j++){
            cout<<"\nIngrese dato: "; cin>>dato;
            queue(vec[i].frente,vec[i].fin,dato);
        }
    }

    return;
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

void apareo(cola vec[],nodo*& lista,int n){
    int i,dato;
    for(i=0;i<n;i++){
        while(vec[i].frente!=NULL){
            dato = unqueue(vec[i].frente,vec[i].fin);
            insertarSinRepetir(lista,dato);
        }
    }

    return;
}

void mostrarCola(nodo* lista){
    nodo* aux = lista;
    cout<<"\nImprimiendo cola apareada...\n";
    while(aux!=NULL){
        cout<<aux->info<<"  ";
        aux = aux->sgte;
    }
    return;
}

/*
Dado un arreglo de N (< 30) colas (nodo = registro + puntero), desarrollar y codificar un procedimiento que aparee las colas 
del arreglo en las mismas condiciones que las definidas en el Ejercicio Nro. 12.
Nota: Retornar la cola resultante y no mantener las anteriores.
*/