#include <iostream>
using namespace std;

    struct club{ //estructura global porque sino se rompe todo
        int numero,deporte;
    }socio;

void data_setter(int,club socio,int[]); //en el prototipo le paso nombre de estructura y la etiqueta
void data_getter(int,int,int,int[]);

int main(){
    int i=0,contador[20]={0},mayor=0,codigo=0;
    club socio1;
    
    data_setter(i,socio1,contador); //le paso el nombre de la etiqueta
    data_getter(i,mayor,codigo,contador);

   return 0;
}

//pido al usuario los socios y los codigos de deporte
void data_setter(int i, struct club socio,int contador[]){
    cout<<"\nIngrese número de socio: ";
    cin>>socio.numero;
    for(i=0;i<20;i++){
    while(socio.numero != 0){
            cout<<"\nIngrese código de deporte: ";
            cin>>socio.deporte;
            if(socio.deporte >= 1 && socio.deporte<=20){
                contador[socio.deporte - 1]++;
            }
            else{
                cout<<"\nCódigo incorrecto.";
            }
            cout<<"\nIngrese número de socio: ";
            cin>>socio.numero;
        }
    }

    return;
}

//muestro cuantos socios tiene cada deporte y cual tiene mas socios
void data_getter(int i,int mayor,int codigo,int contador[]){
    cout<<"\nCantidad de inscriptos: ";
    for(i=0;i<20;i++){
        cout<<"\nDeporte "<<i+1<<": "<<contador[i]<<" socios\n";
    }

    for(i=0;i<20;i++){
        if (contador[i]>mayor){
            mayor=contador[i];
            codigo = i + 1;
        }
    }

    cout<<"\nDeporte con más socios: "<<codigo<<endl;

    return;
}