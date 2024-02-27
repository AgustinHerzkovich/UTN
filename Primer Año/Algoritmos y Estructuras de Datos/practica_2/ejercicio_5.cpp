#include <iostream>
using namespace std;

void data_getter(int,int,int[],int);

int main(){
    int i,j=0,cont=0,vector[50];

    struct dados{
        int dado1;
        int dado2;
    }tirada;

    for (i=0;i<50;i++){
            cout<<"\nIngrese la tirada de dados: ";
            cin>>tirada.dado1>>tirada.dado2;
            vector[i] = tirada.dado1 + tirada.dado2;
    }

    data_getter(i,j,vector,cont);

   return 0;
}

void data_getter(int i,int j,int vector[],int cont){
     for (i=2;i<13;i++){
        while(j<50){
            if(vector[j]==i){
                cont++;
            }
            j++;
        }
        if(i==1){
            cout<<"\n"<<i<<" salió "<<cont<<" vez\n";
        }
        else{
            cout<<"\n"<<i<<" salió "<<cont<<" veces\n";
        }
        cont=0;
        j=0;
    }
}