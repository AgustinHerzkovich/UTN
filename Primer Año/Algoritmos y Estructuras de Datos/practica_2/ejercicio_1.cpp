#include <iostream>
using namespace std;
void funcion(int,int); //prototipo de funcion
int main(){
    int n,num=2; //variable num importante para sumar los pares
    cout<<"\nIngrese un numero menor que 30: ";
    cin>>n;
    while(n>30){
    cout<<"\nIngrese un numero menor que 30: ";
    cin>>n;
    }
    funcion(n,num); //invocacion 
    return 0;
}

void funcion(int n, int num){ // funcion que crea vector de n posiciones y almacena los primeros n pares
    int vec[n]; 
    for (int i=0;i<n;i++){ //suma de a 2 y almacena el numero en el vector la cantidad n de veces
        vec[i]=num;
        num+=2; 
    }
    for (int i=0;i<n;i++){ //imprime vector
        cout<<vec[i]<<endl;
    }
    return;
}