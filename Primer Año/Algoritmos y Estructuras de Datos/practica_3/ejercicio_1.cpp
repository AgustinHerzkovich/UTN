#include <iostream>

using namespace std;

struct alumno{ //creacion de registro estructura
    int legajo;
    float promedio;
};

void archivo(FILE*);

int main(){
    FILE* f=fopen("CURSO.BIN","wb"); //creacion de archivo binario para escribir

    archivo(f);

    fclose(f); //cierra archvivo
    
    return 0;
}

void archivo(FILE* f){
    alumno al;
    float nota1,nota2;

    cout<<"\nIngrese un legajo: "; cin>>al.legajo;
    while(al.legajo>0){ //ingresa legajos mientras que sean positivos
        cout<<"\nIngrese nota 1: "; cin>>nota1;
        cout<<"\nIngrese nota 2: "; cin>>nota2;
        
        al.promedio=(nota1+nota2)/2;

        fwrite(&al,sizeof(alumno),1,f); //guarda en el archivo los registros

        cout<<"\nIngrese un legajo: "; cin>>al.legajo;
    }

    return;
}