#include <iostream>

using namespace std;

struct actas{
    int libro,folio,fecha,codmateria,legajo,nota;
    char nombre[20];
};

int tam(FILE*);
void rellenar(int,actas[],FILE*);
void corte_de_control(int,actas[]);

int main(){
    FILE* f10 = fopen("ACTASFINALES.dat","rb");

    int tamaño = tam(f10);
    actas act1[tamaño];

    rellenar(tamaño,act1,f10);
    corte_de_control(tamaño,act1);

    fclose(f10);

    return 0;
}

int tam(FILE* f10){
    fseek(f10,0,SEEK_END);
    int tamaño = ftell(f10) / sizeof(actas);
    fseek(f10,0,SEEK_SET);

    return tamaño;
}

void rellenar(int tamaño,actas act1[],FILE* f10){
    int i=0,j=0;
    actas aux1;
    while(fread(&aux1,sizeof(actas),1,f10)){
        act1[i] = aux1;
        i++;
    }

    for(i=1;i<tamaño;i++){
        for(j=1;j<=tamaño-i;j++){
            if((act1[j-1].libro > act1[j].libro || (act1[j-1].folio > act1[j].folio && act1[j-1].libro == act1[j].libro))){
                    aux1 = act1[j-1];
                    act1[j-1] = act1[j];
                    act1[j] = aux1;
            }
        }
    }
    return;
}

void corte_de_control(int tamaño, actas act1[]){
    int i=0,ti=0,tau=0,tap=0,td=0,actual;

    while(i<tamaño){
        actual = act1[i].libro;
        cout<<"\n\nLibro: "<<actual;
        cout<<"\nFolio: "<<act1[i].folio;
        ti=0; tau=0; tap=0; td=0;
        while(i<tamaño && actual == act1[i].libro){
            ti++;
            if(act1[i].nota == 0){
                tau++;
            }
            else if(act1[i].nota >= 6){
                tap++;
            }
            else{
                td++;
            }
            i++;
        }
        cout<<"\nAlumnos inscriptos: "<<ti;
        cout<<"\nAlumnos ausentes: "<<tau;
        cout<<"\nAlumnos aprobados: "<<tap;
        cout<<"\nAlumnos desaprobados: "<<td;
    }

    return;
}