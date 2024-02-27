#include <iostream>

using namespace std;

struct TipoAl{
    char alumno[30+1],turno;
    int legajo,curso;
};

void leerArchivo(FILE*,TipoAl[]);
void informarResultados(const int,TipoAl[],int);
void ordenamiento(int,TipoAl[]);
int inicializarVector(FILE*);

int main(){
    FILE* f = fopen("archivo.dat","rb");

    int tam = inicializarVector(f);
    TipoAl alumnos[tam];


    const int cant_cursos = 30;

    int i,CANT;

    for(i=0;i<cant_cursos;i++){
        cout<<"\n\nIngrese cantidad de alumnos por grupo del curso ["<<i+1<<"]: "; cin>>CANT;
        leerArchivo(f,alumnos);
        ordenamiento(tam,alumnos);
        informarResultados(cant_cursos,alumnos,CANT);
    }

    fclose(f);

    return 0;
}


void leerArchivo(FILE* f,TipoAl alumnos[]){
    int i=0;
    TipoAl aux;
    while(fread(&aux,sizeof(TipoAl),1,f)){
        alumnos[i] = aux;
        i++;
    }
    fseek(f,0,SEEK_SET);

    return;
}

void ordenamiento(int tam,TipoAl alumnos[]){
    int i,j;
    TipoAl aux;
    for(i=1;i<tam;i++){
        for(j=1;j<=tam-i;j++){
            if((alumnos[j-1].curso > alumnos[j].curso) || (alumnos[j-1].curso == alumnos[j].curso && alumnos[j-1].legajo > alumnos[j].legajo)){
                aux = alumnos[j-1];
                alumnos[j-1] = alumnos[j];
                alumnos[j] = aux;
            }
        }
    }

    return;
}


void informarResultados(const int cant_cursos,TipoAl alumnos[],int CANT){
    int i=0,actual,contador,total=0,cant_grupos=0;
    while(i<cant_cursos){
        actual = alumnos[i].curso;
        cout<<"\n\nCurso: "<<actual;
        contador=0;
        while(i<cant_cursos && actual ==alumnos[i].curso){
            cout<<"\nLegajos: "<<alumnos[i].legajo;
            contador++;
            i++;
        }
        if((contador%cant_grupos)!=0){
            cant_grupos +=1;
        } 
        cout<<"\nCantidad de grupos del curso: "<<cant_grupos;
        total+=cant_grupos;  
    }
    cout<<"\n\nTotal de grupos: "<<total;

    return;
}


int inicializarVector(FILE* f){
    fseek(f,0,SEEK_END);
    int tam = ftell(f)/sizeof(TipoAl);
    fseek(f,0,SEEK_SET);

    return tam;
}