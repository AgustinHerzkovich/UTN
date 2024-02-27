#include <iostream>
#include <cstring>

using namespace std;

struct Antecedentes{
    int DNI,Dedo,Tipo,Subtipo;
    char ApeNom[50+1];
};

struct infoLS{
    int DNI;
    char ApeNom[50+1];
};

struct nodoLS{
    infoLS info;
    nodoLS* sgte;
};

struct infoLP{
    int Dedo;
    nodoLS* prtls; 
};

struct nodoLP{
    infoLP info;
    nodoLP* sgte;
};

struct dedos{
    char nombre[20+1];
};

FILE* f = fopen("Policial.dat","rb");

nodoLP* matriz[4][9];

//1.
void cargarMatrizSospechosos(FILE* f,nodoLP* matriz[][9]){
    Antecedentes aux;
    infoLS datoLS;
    nodoLP* auxLP = NULL;
    while(fread(&aux,sizeof(Antecedentes),1,f)){
        auxLP = insertarSinRepetir(matriz[aux.Tipo-1][aux.Subtipo-1],aux.Dedo);
        datoLS.DNI = aux.DNI;
        strcpy(datoLS.ApeNom,aux.ApeNom);
        insertarOrdenado(auxLP->info.prtls,datoLS);
    }
    fclose(f);
    return;
}

//2.
void emitirSospechosos(nodoLP* matriz[][9],int tipo,int subtipo){
    dedos vec[10] = {{"Pulgar"},{"Indice"},{"Medio"},{"Anular"},{"Meñique"},{"Meñique"},{"Anular"},{"Medio"},{"Indice"},{"Pulgar"}};
    int dedoSospechoso;
    mostrarLista(matriz[tipo][subtipo]);
    if(matriz[tipo][subtipo]->info.Dedo >=1 && matriz[tipo][subtipo]->info.Dedo <=5){
        cout<<"\nMano derecha";
        dedoSospechoso = matriz[tipo][subtipo]->info.Dedo - 1;
        vec[dedoSospechoso];
    }
    else{
        cout<<"\nMano izquierda";
        dedoSospechoso = matriz[tipo][subtipo]->info.Dedo - 1;
        vec[dedoSospechoso];
    }
    return;
}

