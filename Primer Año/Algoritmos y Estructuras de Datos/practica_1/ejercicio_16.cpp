#include <iostream>
using namespace std;
int main(){
    int ceros=0,pos=0,neg=0,suma2=0,n=0;
    float suma1=0;
    char opcion;
    cout<<"\n---Bienvenido---";
    cout<<"\na)167 valores enteros";
    cout<<"\nb)N valores, donde el valor de N debe ser leido previamente";
    cout<<"\nc)El conjunto de valores termina con un valor igual al anterior";
    cout<<"\nd)Se dan N valores, pero el proceso deberá finalizar si se procesan todos los valores o si la cantidad de ceros supera a cuatro";
    cout<<"\ne)Se dan N valores, pero el proceso deberá finalizar si se cumple alguna de las condiciones d) o si el promedio de positivos resulta mayor que seis";
    cout<<"\nSeleccione una opcion: "; cin>>opcion;
    switch(opcion){
        case 'a':{
            int numeros[167];
            for(int i=0;i<167;i++){
            cout<<"\nIngrese numeros enteros: "; cin>>numeros[i];
            if (numeros[i]==0){
                ceros++;
            }
            else if (numeros[i]>0){
                pos++;
                suma1+=numeros[i];
            }
            else if (numeros[i]<0){
                neg++;
                suma2+=numeros[i];
            }
            }
            if(ceros==1){
                cout<<"\nHubo "<<ceros<<" valor cero";
            }
            else{
                cout<<"\nHubo "<<ceros<<" valores cero";
            }
            cout<<"\nEl promedio de los valores positivos es "<<(suma1/pos);
            cout<<"\nLa sumatoria de los valores negativos es "<<suma2;
            break;
        }
        
        case 'b':{
            cout<<"\nIngrese cantidad de valores: "; cin>>n;
            int numeros[n];
            for (int i=0;i<n;i++){
                cout<<"\nIngrese numeros enteros: "; cin>>numeros[i];
            if (numeros[i]==0){
                ceros++;
            }
            else if (numeros[i]>0){
                pos++;
                suma1+=numeros[i];
            }
            else if (numeros[i]<0){
                neg++;
                suma2+=numeros[i];
            }
            }
            if(ceros==1){
                cout<<"\nHubo "<<ceros<<" valor cero";
            }
            else{
                cout<<"\nHubo "<<ceros<<" valores cero";
            }
            cout<<"\nEl promedio de los valores positivos es "<<(suma1/pos);
            cout<<"\nLa sumatoria de los valores negativos es "<<suma2;
            break;
        }

        case 'c':{
        int numero=0,anterior;
        cout<<"\nIngrese numeros enteros: "; cin>>numero;
        while(numero!=anterior){
            if (numero==0){
                ceros++;
            }
            else if (numero>0){
                pos++;
                suma1+=numero;
            }
            else if (numero<0){
                neg++;
                suma2+=numero;
            }
            anterior=numero;
            cout<<"\nIngrese numeros enteros: "; cin>>numero;
            }
            if(ceros==1){
                cout<<"\nHubo "<<ceros<<" valor cero";
            }
            else{
                cout<<"\nHubo "<<ceros<<" valores cero";
            }
            cout<<"\nEl promedio de los valores positivos es "<<(suma1/pos);
            cout<<"\nLa sumatoria de los valores negativos es "<<suma2;
            break;
        }
    
        case 'd':{
         cout<<"\nIngrese cantidad de valores: "; cin>>n;
            int numeros[n];
            for (int i=0;i<n;i++){
                cout<<"\nIngrese numeros enteros: "; cin>>numeros[i];
            if (numeros[i]==0){
                ceros++;
            }
            else if (numeros[i]>0){
                pos++;
                suma1+=numeros[i];
            }
            else if (numeros[i]<0){
                neg++;
                suma2+=numeros[i];
            }
            if(ceros>4){
                break;
            }
            }
            if(ceros==1){
                cout<<"\nHubo "<<ceros<<" valor cero";
            }
            else{
                cout<<"\nHubo "<<ceros<<" valores cero";
            }
            cout<<"\nEl promedio de los valores positivos es "<<(suma1/pos);
            cout<<"\nLa sumatoria de los valores negativos es "<<suma2;
            break;
        }
        case 'e':{
         cout<<"\nIngrese cantidad de valores: "; cin>>n;
            int numeros[n];
            for (int i=0;i<n;i++){
                cout<<"\nIngrese numeros enteros: "; cin>>numeros[i];
            if (numeros[i]==0){
                ceros++;
            }
            else if (numeros[i]>0){
                pos++;
                suma1+=numeros[i];
            }
            else if (numeros[i]<0){
                neg++;
                suma2+=numeros[i];
            }
            if(ceros>4||(suma1/pos)>6){
                break;
            }
            }
            if(ceros==1){
                cout<<"\nHubo "<<ceros<<" valor cero";
            }
            else{
                cout<<"\nHubo "<<ceros<<" valores cero";
            }
            cout<<"\nEl promedio de los valores positivos es "<<(suma1/pos);
            cout<<"\nLa sumatoria de los valores negativos es "<<suma2;
            break;
        }
        default: cout<<"\nOpcion incorrecta";
            break;
    }
   return 0;
}