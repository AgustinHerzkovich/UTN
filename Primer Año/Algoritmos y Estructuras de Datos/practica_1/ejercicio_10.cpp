#include <iostream>
using namespace std;
int main(){
   float n;
   int cant1=0,cant2=0,cant3=0,cant4=0;
   cout<<"\nIngrese el sueldo del empleado: "; cin>>n;
   while(n!=0){
    if (n<1520){
        cant1++;
    }
    if (n>=1520&&n<2780){
        cant2++;
    }
    if (n>=2780&&n<5999){
        cant3++;
    }
    if (n>=5999){
        cant4++;
    }
    cout<<"\nIngrese el sueldo del empleado: "; cin>>n;
   } 
   cout<<endl<<cant1<<" empleados ganan menos de $1520";
   cout<<endl<<cant2<<" empleados ganan entre $1520 y $2780";
   cout<<endl<<cant3<<" empleados ganan entre $2780 y $5999";
   cout<<endl<<cant4<<" empleados ganan mas de $5999";
   return 0;
}