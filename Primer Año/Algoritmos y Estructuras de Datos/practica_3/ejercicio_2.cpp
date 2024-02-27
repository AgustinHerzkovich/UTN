#include <iostream>
#include <cstring>

using namespace std;

struct dat{
    char nombre[20],apellido[20];
    int numlegajo,codigomateria,dia,mes,año;
};

void archivo();

int main(){
    
    archivo();
    
    return 0;
}

void archivo(){
    FILE* f1 = fopen("DIAFINALES.DAT","wb");
    dat datos;

    cout<<"\nIngrese nombre: "; cin>>datos.nombre;
    cout<<"\nIngrese apellido: "; cin>>datos.apellido;
    while(strcmp(datos.nombre,"x")!=0 && strcmp(datos.apellido,"x")!=0){
        cout<<"\nIngrese número de legajo: "; cin>>datos.numlegajo;
        cout<<"\nIngrese código de materia: "; cin>>datos.codigomateria;
        cout<<"\nIngrese día: "; cin>>datos.dia;
        cout<<"\nIngrese mes: "; cin>>datos.mes;
        cout<<"\nIngrese año: "; cin>>datos.año;

        fwrite(&datos,sizeof(dat),1,f1);

        cout<<endl<<endl<<"Ingrese nombre: "; cin>>datos.nombre;
        cout<<endl<<"Ingrese apellido: "; cin>>datos.apellido;
    }

    fclose(f1);
    return;
}