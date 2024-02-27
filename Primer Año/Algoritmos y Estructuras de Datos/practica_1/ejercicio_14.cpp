#include <iostream>
using namespace std;
int main(){
    int i,id=0,peso=0,peso_total=0,cantidad1=0,cantidad2=0,cantidad3=0,mayor=0,id_mayor=0;
    char puerto;
    for(i=0;i<100;i++){
        cout<<"\nIdentificador del contenedor ñ: "; cin>>id;
        cout<<"\nPeso del contenedor: "; cin>>peso;
        cout<<"\nPuerto de arribo: "; cin>>puerto; 
        peso_total+=peso;
        if(peso>mayor){
            mayor=peso;
            id_mayor=id;
        }
        if(puerto=='1'){
            cantidad1++;
        }
        if(puerto=='2'){
            cantidad2++;
        }
        if(puerto=='3'){
            cantidad3++;
        }
    }
    cout<<"\nEl peso total que el buque debe trasladar es: "<<peso_total;
    cout<<"\nLa identificacion del contenedor de mayor peso es: "<<id_mayor;
    cout<<"\nContenedores a trasladar al puerto 1: "<<cantidad1;
    cout<<"\nContenedores a trasladar al puerto 2: "<<cantidad1;
    cout<<"\nContenedores a trasladar al puerto 3: "<<cantidad1;
    return 0;
}