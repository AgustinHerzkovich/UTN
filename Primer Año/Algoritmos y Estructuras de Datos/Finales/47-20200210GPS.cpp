#include <iostream>

using namespace std;

struct coords{
    int longi,lat,alt;
};

struct datos{
    coords inicio;
    coords fin;
    int ruta,tramo,vel,mind;
};

int busquedaBinaria(int,datos[],int,int);
int CalcularTiempoDeLlegada(int,datos[],int,int,int);
int distancia(int,int,int,int,int,int);


int busquedaBinaria(int n,datos vec[],int rutaE,int tramoE){
    int inf = 0;
    int sup = n-1;
    int mitad;

    while(inf<=sup){
        mitad = (inf+sup)/2;
        if(vec[mitad].ruta > rutaE || (vec[mitad].ruta == rutaE && vec[mitad].tramo > tramoE)){
            sup = mitad - 1;
        }
        else if(vec[mitad].ruta < rutaE || (vec[mitad].ruta == rutaE && vec[mitad].tramo < tramoE)){
            inf = mitad + 1;
        }
        else{
            return mitad;
        }
    }
    return -1;
}

int CalcularTiempoDeLlegada(int n,datos vec[],int rutaE,int tramoE,int hora){
    int pos = busquedaBinaria(n,vec,rutaE,tramoE);
    coords inicio = vec[pos].inicio;
    coords fin = vec[pos].fin;

    int tiempoT = ((distancia(inicio.longi,inicio.lat,inicio.alt,fin.longi,fin.lat,fin.alt)*60)/vec[pos].vel) + vec[pos].mind;
    int horaL = (hora + (tiempoT/60*100) + (tiempoT %60) %2400);
    return horaL;

}

int distancia(int a,int b,int c,int d,int e,int f){

    return 0;
}