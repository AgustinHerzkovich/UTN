#include <iostream>
#include <cstring>

using namespace std;

//declaracion de estructura de tipo de dato enumerado
typedef enum {
    BuenosAires, CABA, Catamarca, Chaco, Chubut, Cordoba, Corrientes,
    EntreRios, Formosa, Jujuy, LaPampa, Rioja, Mendoza, Misones, Neuquen,
    Rionegro, Salta, SanJuan, Santacruz, SantaFe, SgoEstero, TdelFuego, Tucuman
}Provincia;

//declaracion de struct
struct archVotos{
    Provincia provincia;
    int partido,localidad,padron,blancos,impugnados,listas[5];
}; 

struct archCandidatos{
    int numLista;
    char presidente[30+1],vicepresidente[30+1];
};

struct matrizVotos{
    int padron,blancos,impugnados,listas[5];
};

struct vector{
    archCandidatos arch;
    int votos=0;
};

//declaracion de estructuras de datos a utilizar
matrizVotos Votos[24][10][20];
vector v[5];
FILE* f1 = fopen("Votos.dat","rb");
FILE* f2 = fopen("Candidatos.dat","rb");

//prototipos de funciones
void Burbuja(vector[],int);
void cargarVotos(FILE*,matrizVotos[][10][20],vector[]);
void cargarCandidatos(FILE*,vector[]);
char* presidente(FILE*,matrizVotos[][10][20]);
char* vicepresidente(FILE*,matrizVotos[][10][20]);

//funcion cargar votos en la matriz
void cargarVotos(FILE* f1,matrizVotos votos[][10][20],vector v[]){
    int i;
    archVotos aux;
    while(fread(&aux,sizeof(archVotos),1,f1)){
        votos[aux.provincia][aux.partido][aux.localidad].padron = aux.padron;
        votos[aux.provincia][aux.partido][aux.localidad].blancos = aux.blancos;
        votos[aux.provincia][aux.partido][aux.localidad].impugnados = aux.impugnados;
        for(i=0;i<5;i++){
            votos[aux.provincia][aux.partido][aux.localidad].listas[i] = aux.listas[i];
            v[i].votos += aux.listas[i];
        }
    }
    return;
}

//funcion que carga el vector de candidatos
void cargarCandidatos(FILE* f2,vector v[]){

    return;
}

//funcion determinar el presidente
char* presidente(FILE* f2,vector v[]){
    archCandidatos aux;
    Burbuja(v,5);
    int i;
    int total = 0;
    float porc;
    for(i=0;i<5;i++){
        total += v[i].votos;
    }
    porc = total/v[0].votos;
    if(porc>=0.45 || (porc>=0.4 && (porc-(total/v[1].votos))>= 0.1)){
        return v->arch.presidente;
    }
    else{
        cout<<"\nHay segunda vuelta"<<endl;
    }
    return;
}