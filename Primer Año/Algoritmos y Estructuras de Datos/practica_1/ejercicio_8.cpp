#include <iostream>
using namespace std;
int main(){
    int n,cant=0,suma1=0,suma2=0,i;
    for (i=0;i<=50;i++){
        cout<<"Ingrese un numero entero: ";cin>>n;
        if(n>100){
            suma1+=n;
            cant++;
        }
        if (n<-10){
            suma2+=n;
        }
    }
    cout<<"\nEl promedio de los mayores que 100 es: "<<(suma1/cant);
    cout<<"\nLa suma de los menores que -10 es: "<<suma2;
    return 0;
}