#include <iostream>
#include <cstring>

using namespace std;

//INFORMAR
/*
a)	Por cada operador: ¿de qué países recibió buzos?
b)	Por cada operador: ¿cuántos buceos se hicieron a 30 metros o más?
c)	Por cada operador: ¿cuántos buceos nocturnos se hicieron?
*/

//1.
struct regArch{
    char opBuceo[20+1];
    int nroDoc;
    int edad;
    char pais[20+1];
    int fecha[3];
    char sitio[20+1];
    char nivelDificultad; //'A' = Alta, 'M' = Media, 'B' = Baja
    float profundidadMax;
    float tiempoBuceo;
    int horaInicio;
};


FILE* f = fopen("buceosGalápagos2022.dat","rb");
regArch auxArchh; //para leer el archivo


//2.
struct infoN{
    char opBuceo[20+1];
    char pais[20+1];
    float profundidadMax;
    int horaInicio;
};
struct nodo{
    infoN info;
    nodo* sgte;
};

nodo* lista = NULL;

void cargarEstructura(FILE* f,nodo*& lista){
    regArch auxArch; //para leer el archivo
    infoN auxL;
    while(fread(&auxArch,sizeof(regArch),1,f)){
        strcpy(auxL.opBuceo,auxArch.opBuceo);
        strcpy(auxL.pais,auxArch.pais);
        auxL.profundidadMax = auxArch.profundidadMax;
        auxL.horaInicio = auxArch.horaInicio;
        insertarOrdenado(lista,auxL);
    }
    fclose(f);
    return;
}

//3.
void listarEstadisticas(nodo* lista){
    nodo* aux = lista;
    char operadorActual[20+1];
    int contador[2];
    cout<<"\nINFORMES";
    while(aux!=NULL){
        contador[0] = 0;
        contador[1] = 0;
        strcpy(operadorActual,aux->info.opBuceo);
        cout<<"\nOperador "<<operadorActual;
        cout<<"\n  Recibio buzos de los siguientes paises: ";
        while(aux!=NULL && strcmp(operadorActual,aux->info.opBuceo) == 0){
            cout<<endl<< "    " << aux->info.pais;
            if(aux->info.profundidadMax >= 30){
                contador[0]++;
            }
            if(aux->info.horaInicio > 1900){
                contador[1]++;
            } 
            aux = aux->sgte;
        }
        cout << "\n  Buceos a más de 30 metros: " << contador[0] << endl;
        cout << "  Buceos nocturnos: " << contador[1] << endl;
    }

    return;
}


