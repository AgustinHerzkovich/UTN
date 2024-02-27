#include <iostream>
using namespace std;

void funcion();

int main(){
    funcion();

    return 0;
}

void funcion(){
    int a,b;
    cout<<"\nIngrese dos números: "; cin>>a>>b;
    cout<<"\nLa suma de los números es: "<<a+b;
    cout<<"\nEl producto de los números es: "<<a*b;

    return;
}