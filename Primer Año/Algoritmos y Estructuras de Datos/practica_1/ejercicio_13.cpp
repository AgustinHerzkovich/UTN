#include <iostream>
using namespace std;
int main(){
    float n,mayor=-10000000,menor=10000000,rango=26.9,suma=0,cant=0;
    cout<<"\nIngrese un valor: "; cin>>n;
    while(n!=0){
        if(n<0){
            if(n>mayor){
                mayor=n;  
            }
            suma+=n;
            cant++;
        }
        if(n>0){    
            if(n<menor){
                menor=n;
            }
            suma+=n;
            cant++;
        }
        if(n>-17.3&&n<26.9){
            if(n<rango){
                rango=n;
            }
            suma+=n;
            cant++;
        }
        cout<<"\nIngrese un valor: "; cin>>n;
    }
    cout<<"\nEl valor maximo negativo es: "<<mayor;
    cout<<"\nEl valor minimo positivo es: "<<menor;
    cout<<"\nEl valor mnimo dentro del rango -17.3 y 26.9 es: "<<rango;
    cout<<"\nEl promedio de todos los valores es: "<<(suma/cant);
   return 0;
}