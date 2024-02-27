#include <iostream>
using namespace std;
int main(){
    int n,i,v,mayor=0,menor=100000,px,py;
    cout<<"\nCantidad de valores a ingresar: "; cin>>n;
    for(i=1;i<=n;i++){
        cout<<"\nIngrese un valor: "; cin>>v;
        if(v>mayor){
            mayor=v;
            px=i;
        }
        if(v<menor){
            menor=v;
            py=i;
        }
    }
    cout<<"\nEl mayor de los numeros es: "<<mayor<<" y su posicion es: "<<px;
    cout<<"\nEl menor de los numeros es: "<<menor<<" y su posicion es: "<<py;
   return 0;
}