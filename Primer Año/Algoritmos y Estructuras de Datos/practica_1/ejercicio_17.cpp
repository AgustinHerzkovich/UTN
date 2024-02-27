#include <iostream>
using namespace std;
float CalcularPorcentajeDiferencia(int,int),resultado; 
int a,b;
int main(){
   cout<<"\nIngrese dos numeros: ";
   cin>>a>>b;
   resultado=CalcularPorcentajeDiferencia(a,b);
   cout<<"\nEl resultado es: "<<resultado;
   return 0;
}

float CalcularPorcentajeDiferencia(int A ,int B){
   return ((B-A) *100 / (A+B));
}
