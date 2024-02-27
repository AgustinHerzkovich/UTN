#include <iostream>

using namespace std;

//1
struct nodo{
    int info;
    nodo* sgte;
};

//funciones de biblioteca

int pop(nodo*& pila){
   int x; //crear una variable x
   nodo* p = pila; //crear una variable auxiliar de tipo nodo
   x = pila->info; //conservar el valor del primer nodo
   pila = p->sgte; //avanzar con la pila un nodo
   delete p; //eliminar el nodo que estaba primero

   return x; //retornar la info que estaba en el primer nodo
}

nodo* buscar(nodo* lista, int buscado){
    nodo* aux = lista; //nodo auxiliar para recorrer la lista
    while(aux!=NULL && aux->info != buscado){ //avanzo mientras haya datos y mientras la info no coincida
        aux = aux->sgte; //avanzo con aux
    }

    return aux; //retorna la direccion del nodo que contiene la info buscada, o NULL si no la encontró
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

nodo* insertarSinRepetir(nodo*& lista,int info){
    nodo* encontro = buscar(lista,info); //nodo para saber si encontró el dato
    if(encontro == NULL){ //si no lo encontró
        encontro = insertarOrdenado(lista,info); //lo agrega a la lista
    }

    return encontro; //retorno lo que encontró
}

int busquedaBinaria(int vec[], int tLogico, int buscado)
{
    int p = 0;
    int u = tLogico - 1;
    int m;
    while(p <= u)
    {
        m = (p+u)/2;
        if(vec[m] == buscado)
            return m;
        if(vec[m] < buscado)
            p = m + 1;
        if(vec[m] > buscado)
            u = m - 1;
    }
    return -1;
}


void burbuja(int vec[], int tLogico) // Burbuja
{
    int i, j;
    int aux;
    for(i = 1; i < tLogico; i++)
    {
        for(j = 1; j <= tLogico - i; j++)
        {
            if(vec[j-1] > vec[j])
            {
                aux = vec[j-1];
                vec[j-1] = vec[j];
                vec[j] = aux;
            }
        }
    }
    return;
}

nodo* pila = NULL;
nodo* frenteCola = NULL;
nodo* finCola = NULL;
/*
//1.a)
nodo* listaOrdenada(nodo*& pila,nodo*& frente,nodo*& fin){
    nodo* lista = NULL;

    while(pila!=NULL){
        insertarOrdenado(lista,pop(pila));
    }
    while(frente!=NULL){
        insertarOrdenado(lista,unqueue(frente,fin));
    }

    return lista;
}
*/
//1.b)

nodo* listaInterseccion(nodo*& lista, int vec[], int n){
    nodo* nuevalista = NULL;
    burbuja(vec, n);
    int indice;
    while(lista!=NULL && n > 0){
        indice = busquedaBinaria(vec, n, lista->info);
        if(indice >= 0){
            for(int i = indice; i < n-1; i++){
                vec[i] = vec[i+1];
            }
            n--;
            insertarOrdenado(nuevalista,lista->info);
            lista = lista->sgte;
        }
    }
    return nuevalista;
}


//metodo tadeo
/*
nodo* listaInterseccion(nodo* &lista, int vec[], int n)
{
    nodo* nuevaLista = NULL;
    burbuja(vec, n);
    int i = 0;
    while(i < n && lista != NULL)
    {
        if(vec[i] > lista->info)
            pop(lista);
        
        else if(vec[i] < lista->info)
            i++;

        else
        {
            insertarOrdenado(nuevaLista, vec[i]);
            i++;
            pop(lista);
        }
    }
    return nuevaLista;
}
*/
/*
//2
struct reg{
    int id;
    float ventas;
    char sector;
};

struct nodoL{
    nodoL* sgte;
    reg info;
}

FILE* f = ("Ventas.dat","rb");

//2.a)
void listaordenada(FILE* f){
    reg aux;
    nodoL* lista = new nodoL();
    while(fread(&aux,sizeof(reg),1,f)){
        if(aux.sector == 'C'){
            insertarOrdenado(lista,aux); //insertarOrdenado por ventas
        }
    }

    nodoL* auxL = lista
    while(auxL!=NULL){
        cout<<"Id: "<<auxL->info.id << endl;
        cout<<"Ventas: "<<auxL->info.ventas << endl;
        cout<<"Sector: "<<auxL->info.sector << endl;
        auxL = auxL->sgte;
    }
    return;
}
*/


void mostrarLista(nodo* lista){
    nodo* aux = lista;
    cout<<"\nImprimiendo lista...\n";
    while(aux!=NULL){
        cout<<aux->info<<"  ";
        aux = aux->sgte;
    }
    return;
}

int main()
{    
    return 0;
}