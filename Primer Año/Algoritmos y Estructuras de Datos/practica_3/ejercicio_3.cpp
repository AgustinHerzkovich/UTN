#include <iostream>

using namespace std;

struct dat{
    char nombre[20],apellido[20];
    int numlegajo,codigomateria,dia,mes,año;
};

int solicitar_codigo();
void escribir(int,FILE*,FILE*);
void leer(FILE*);


int main(){
    FILE* f1 = fopen("DIAFINALES.DAT","rb");
    FILE* f2 = fopen("MATFINALES.DAT","wb+");

    int cod = solicitar_codigo();
    escribir(cod,f1,f2);
    leer(f2);

    fclose(f1);
    fclose(f2);

    return 0;
}

int solicitar_codigo(){
    int cod;
    cout<<"\nSolicite un código de materia: "; cin>>cod;

    return cod;
}

void escribir(int cod,FILE* f1,FILE* f2){
    dat datos;
    while(fread(&datos,sizeof(dat),1,f1)){
        if(datos.codigomateria == cod){
            fwrite(&datos,sizeof(dat),1,f2);
        }
    }

    fseek(f2,0,SEEK_SET);

    return;
}

void leer(FILE* f2){
    int i=0;
    dat datos;
    cout<<"\n\nLOS REGISTROS QUE SE CORRESPONDEN CON DICHO CÓDIGO SON:";
    while(fread(&datos,sizeof(dat),1,f2)){
        cout<<"\n\nNombre ["<<i+1<<"]: "<<datos.nombre;
        cout<<"\nApellido ["<<i+1<<"]: "<<datos.apellido;
        cout<<"\nNúmero de Legajo ["<<i+1<<"]: "<<datos.numlegajo;
        cout<<"\nCódigo de Materia ["<<i+1<<"]: "<<datos.codigomateria;
        cout<<"\nDía ["<<i+1<<"]: "<<datos.dia;
        cout<<"\nMes ["<<i+1<<"]: "<<datos.mes;
        cout<<"\nAño ["<<i+1<<"]: "<<datos.año;
        i++;
    }
    
    return;
}