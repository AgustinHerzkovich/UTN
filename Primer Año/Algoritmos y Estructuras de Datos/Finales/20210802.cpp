#include <iostream>
#include <cstring>

using namespace std;



// vector
struct infoL{
    char patente[7+1];
    int hora;
};

struct nodoL{
    infoL info;
    nodoL* sgte;
};

struct regVec{
    int zona;
    char deno[30+1];
    nodoL* listaVehiculos;
};

// LISTA RECORRIDO
struct infoLR{
    char deno[30+1];
    int hora;
};

struct nodoLR{
    infoLR info;
    nodoLR* sgte;
};

// african slave (nigger elias)
struct sospechoso{
    char patente[7+1];
    char delito[50+1];
    int hora;
};

struct VehiculoSospechoso{    
    sospechoso s;
    nodoLR* recorrido;
};

regVec vec[10];

nodoL* buscar(nodoL*&, char[]);
nodoL* insertarOrdenado(nodoL*&, infoL);

VehiculoSospechoso recorrido(regVec[], sospechoso);

int main(){
    return 0;
}

VehiculoSospechoso recorrido(regVec v[], sospechoso sosp)
{
    VehiculoSospechoso VS;
    VS.s = sosp;
    VS.recorrido = NULL;

    infoLR auxLR;
    nodoL* nodoAux;
    for(int i = 0; i < 10; i++)
    {
        nodoAux = v[i].listaVehiculos;
        while(nodoAux != NULL)
        {
            if(strcmp(nodoAux->info.patente, sosp.patente)==0)
            {
                strcpy(auxLR.deno, v[i].deno);
                auxLR.hora = nodoAux->info.hora;
                InsertarOrdenado(VS.recorrido, auxLR);
            }
            nodoAux = nodoAux->sgte;
        }
    }
    if(VS.recorrido->info.hora < sosp.hora)
    {
        VS.s.hora = VS.recorrido->info.hora; // El crimen comenzó antes
    }
    return VS;
}