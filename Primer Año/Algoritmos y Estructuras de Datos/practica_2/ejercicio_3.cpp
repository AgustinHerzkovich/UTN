#include <iostream>
#include <stdlib.h>
using namespace std;

//prototipos de funciones
void input(int&); 
void fill(int&, int&, int&, int[]);
void min(int&, int[], int&, int[], int&, int&);
void output(int&, int&, int[], int&);
void error();

//funcion principal donde se crea el vector vec y se invocan a las funciones
int main(){
    int n,count=0,valor,minimo,posicion[100],pos=0,producto=1;
    input(n);
    int vec[n];
    fill(count,n,valor,vec);
    min(minimo,vec,count,posicion,pos,producto);
    output(minimo,pos,posicion,producto);
    return 0;
}

//funcion donde el usuario ingresa cant de pos del vector
void input(int& n){ 
    cout<<"\nIngrese cantidad de posiciones (menor a 100): "; cin>>n;
    while(n>=100){
        cout<<"\nIngrese cantidad de posiciones (menor a 100): "; cin>>n;
    }
    return;
}

//rellena el vector con numeros hasta que uno sea 0 o el maximo de posiciones
void fill(int& count, int& n, int& valor, int vec[]){ 
    while(count < n){
        cout<<"\nIngrese datos: "; cin>>valor;
        if(valor==0){
            if(count==0){
                error();
            }
            break;
        }
        vec[count]=valor;
        count++;
    }
    return;
}

//funcion donde se analiza cual es el minimo valor, si se repiten, y en que posicion/es esta/n
void min(int& minimo, int vec[], int& count, int posicion[], int& pos, int& producto){
    minimo = vec[0];
    for(int i=0;i<count;i++){
        if(vec[i]<=minimo){
            minimo=vec[i];
            posicion[i]=i;
            pos++;
        }
        if((vec[i]%2)!=0 && (i%2)==0){
            producto*=vec[i];
        }
    }
    return;
}

//muestra en pantalla el minimo y el producto de impares en pos par
void output(int& minimo, int& pos, int posicion[], int& producto){
    cout<<"\nEl valor minimo es: "<<minimo<<" y se encuentra en la/s posicion/es: ";
    for(int i=0;i<pos;i++){
        cout<<posicion[i]<<" ";
    }
    cout<<"\nEl producto de los numeros impares en posicion par es: "<<producto;
    return;
}

//funcion que cierra el programa
void error(){
    cout<<"\nIngresaste como primer valor '0', por lo tanto, chau.";
    exit(1);
}
