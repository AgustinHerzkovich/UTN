#include <iostream>

using namespace std;

struct archivo{
    char apeynom[35+1];
    int legajo;
    int division;
};

struct nodo{
    archivo info;
    nodo* sgte;
};

nodo* insertarOrdenado(nodo*&,int);
archivo pop(nodo*&);
void mostrar(nodo*);

int main(){

        FILE* f = fopen("reg.dat","rb");
        nodo* lista = NULL;

        archivo arch;

        while(fread(&arch,sizeof(archivo),1,f)){
            insertarOrdenado(lista,arch);
        }

        mostrar(lista);

    return 0;
}

nodo* insertarOrdenado(nodo*& lista,archivo info){
    nodo* p = new nodo(); //crear nuevo nodo
    p->info = info; //insertar dato en el nodo
    p->sgte = NULL; //hacer que el nuevo nodo apunte a NULL
    if(lista == NULL || info.division < lista->info.division){ //si está vacía o si la info que se quiere agregar es menor a la que ya hay
        p->sgte = lista; //el nuevo nodo en el campo siguiente apunta a lista
        lista = p; //lista apunta a p
    }
    else{ //sino
        nodo* q = lista; //crea un nodo auxiliar que apunte a lista
        while(q->sgte != NULL && q->sgte->info.division < info.division){ //mientras haya datos y mientras el dato siguiente sea menor que el actual
            q = q->sgte; //avanzo con el auxiliar
        }
        p->sgte = q->sgte; //nuevo nodo siguiente apunta a auxiliar siguiente
        q->sgte = p; //auxiliar siguiente apunta a nuevo nodo
    }

    return p; //retorna p
}

archivo pop(nodo*& pila){
   archivo x; //crear una variable x
   nodo* p = pila; //crear una variable auxiliar de tipo nodo
   x = pila->info; //conservar el valor del primer nodo
   pila = p->sgte; //avanzar con la pila un nodo
   delete p; //eliminar el nodo que estaba primero

   return x; //retornar la info que estaba en el primer nodo
}

void mostrar(nodo* lista){
    archivo aux;
    while(lista!=NULL){
        aux = pop(lista);
        cout<<aux.legajo<<endl;
    }
    cout<<endl;

    return;
}

/*
Dado un archivo de registros de alumnos, donde cada registro contiene:
a) Apellido y Nombre del alumno (35 caracteres)
b) Número de legajo (7 dígitos)
c) División asignada (1 a 100)
ordenado por número de legajo, desarrollar el algoritmo y codificación 
del programa que imprima el listado de alumnos por división, 
ordenado por división y número de legajo crecientes, a razón de 
55 alumnos por hoja.
*/