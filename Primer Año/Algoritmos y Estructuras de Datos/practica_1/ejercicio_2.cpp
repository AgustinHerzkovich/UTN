#include <iostream>

using namespace std;

void funcion();

int main(){
    funcion();
    return 0;
}

void funcion(){
    int n,año,mes,dia;
    cout<<"\nIngrese una fecha(AAAAMMDD): "; cin>>n;
    año = n/10000;
    mes = (n%10000)/100;
    dia = (n%100);
    cout<<"\nEl año es: "<<año;
    cout<<"\nEl mes es: "<<mes;
    cout<<"\nEl dia es: "<<dia;
    
    return;
}