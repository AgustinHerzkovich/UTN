#include <iostream>
#include <cstring>
using namespace std;
int main(){
    char n[20],maximo[20],minimo[20];
    float edad,año,mes,dia,mayor=0,menor=20000000;
    int fecha;
    cout<<"\nIngrese el nombre: "; cin>>n;
    while(strcmp(n,"FIN")!=0){
        cout<<"\nIngrese fecha de nacimiento: "; cin>>fecha;
        año = fecha/10000;
        mes = ((fecha%10000)/100);
        dia = (fecha%100);
        edad = (2023 - año)+(mes/12)+(dia/365);
        if (edad>mayor){
            mayor=edad;
            strcpy(maximo,n);
        }
        if(edad<menor){
            menor=edad;
            strcpy(minimo,n);
        }
    cout<<"\nIngrese el nombre: "; cin>>n;
    } 
    cout<<"El mayor es: ";
    for(int i=0;i<20&&maximo[i]!='\0';i++){
        cout<<maximo[i];
    }
    cout<<endl<<"El menor es: ";
    for(int i=0;i<20&&minimo[i]!='\0';i++){
        cout<<minimo[i];
    }
   return 0;
}