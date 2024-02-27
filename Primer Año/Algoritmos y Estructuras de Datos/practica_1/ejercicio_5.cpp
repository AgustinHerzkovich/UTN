#include <iostream>
using namespace std;
int main(){
    int a,b,c;
    cout<<"\nIngrese los lados del triangulo: "; cin>>a>>b>>c;
    if(a==b&&b==c){
        cout<<"\nEl triangulo es equilatero";
    }
    else if(a==b||b==c||a==c){
        cout<<"\nEl triangulo es isosceles";
    }
    else{
       cout<<"\nEl triangulo es escaleno"; 
    }
   return 0;
}