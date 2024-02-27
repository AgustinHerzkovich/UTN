#include <iostream>
#include <cstring>

using namespace std;

struct archivo{
    char apeynom[35+1];
    int legajo;
    char division[4+1];
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

        fseek(f,0,SEEK_END);
        int tamaño = ftell(f)/sizeof(archivo);
        fseek(f,0,SEEK_SET);
        archivo vec[tamaño];
        int i,j;

        for(i=1;i<tamaño;i++){
            for(j=1;j<tamaño-i;j++){
                if(vec[j-1].legajo>vec[j].legajo){
                    arch = vec[j-1];
                    vec[j-1] = vec[j];
                    vec[j] = arch; 
                }
            }
        }
        i=0;

        while(fread(&vec[i],sizeof(archivo),1,f)){
            insertarOrdenado(lista,arch);
            i++;
        }

        mostrar(lista);

    return 0;
}

nodo* insertarOrdenado(nodo*& lista,archivo info){
    nodo* p = new nodo(); //crear nuevo nodo
    p->info = info; //insertar dato en el nodo
    p->sgte = NULL; //hacer que el nuevo nodo apunte a NULL
    if(lista == NULL || strcmp(info.division, lista->info.division)==-1){ //si está vacía o si la info que se quiere agregar es menor a la que ya hay
        p->sgte = lista; //el nuevo nodo en el campo siguiente apunta a lista
        lista = p; //lista apunta a p
    }
    else{ //sino
        nodo* q = lista; //crea un nodo auxiliar que apunte a lista
        while(q->sgte != NULL && strcmp(q->sgte->info.division, info.division)==1){ //mientras haya datos y mientras el dato siguiente sea menor que el actual
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
    cout<<"\nLista: \n";
    archivo aux;
    char divisionActual[4+1] = "";
    while(lista!=NULL){
        aux = pop(lista);
        if(strcmp(aux.division,divisionActual)!=0){
            strcpy(divisionActual,aux.division);
            cout<<"División: "<<divisionActual<<"\n";
        }
        cout<<"Nombre: "<<aux.apeynom<<"\n";
        cout<<"Legajo: "<<aux.legajo<<"\n";
    }
    cout<<endl;

    return;
}

/*
Idem Ejercicio Nro. 13 pero considerando que las divisiones asignadas 
son 100 y se identifican con un código de 4 caracteres.
*/