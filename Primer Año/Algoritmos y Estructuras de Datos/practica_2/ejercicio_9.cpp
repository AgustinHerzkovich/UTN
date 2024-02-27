#include <iostream>
#include <cstring>

using namespace std;

struct conjunto{
    char nombre[20];
    int fecha;
};

void pedirnum(int&);
void rellenardatos(int,struct conjunto[]);
void ordenarpornombre(int,struct conjunto[]);
void ordenporfecha(int,conjunto[]);

int main(){
    int n;
    pedirnum(n);
    conjunto conj[n];
    rellenardatos(n,conj);
    ordenarpornombre(n,conj);
    ordenporfecha(n,conj);
   
   return 0;
}

void pedirnum(int& n){
    cout<<"\nIngrese un número (N<=50): "; cin>>n;
    while(n>50){
        cout<<"\nIngrese un número (N<=50): "; cin>>n;
    }
    
    return;
}

void rellenardatos(int n, conjunto conj[]){
    int i;
    for(i=0;i<n;i++){
        fflush(stdin);
        cout<<"\nIngrese nombre: "; cin.getline(conj[i].nombre,20,'\n');
        cout<<"\nIngrese fecha: "; cin>>conj[i].fecha;
    }
    return;
}

void ordenarpornombre(int n, conjunto conj[]){
    int i,j,auxfecha;
    char auxnombre[20];
    for(i=0;i<n;i++){
            for(j=0;j<n-1;j++){
                if((strcmp(conj[j].nombre,conj[j+1].nombre))>0){
                strcpy(auxnombre,conj[j].nombre);
                auxfecha=conj[i].fecha;
                strcpy(conj[j].nombre,conj[j+1].nombre);
                conj[j].fecha=conj[j+1].fecha;
                strcpy(conj[j+1].nombre,auxnombre);
                conj[j+1].fecha=auxfecha;
                }
            }
       }
       
    cout<<"\nOrden por nombres\n";
    for(i=0;i<n;i++){
        cout<<"Nombre: "<<conj[i].nombre<<"  Fecha: "<<conj[i].fecha<<endl;
    }
    return;
}

void ordenporfecha(int n, conjunto conj[]){
    int i,j,auxfecha;
    char auxnombre[20];
    for(i=0;i<n;i++){
            for(j=0;j<n-1;j++){
                if(conj[j].fecha % 10000 > conj[j+1].fecha % 10000){
                strcpy(auxnombre,conj[j].nombre);
                auxfecha=conj[i].fecha;
                strcpy(conj[j].nombre,conj[j+1].nombre);
                conj[j].fecha=conj[j+1].fecha;
                strcpy(conj[j+1].nombre,auxnombre);
                conj[j+1].fecha=auxfecha;
                }
                else if (conj[j].fecha % 10000 == conj[j+1].fecha % 10000){
                    if(((conj[j].fecha / 10000) % 100) > ((conj[j+1].fecha / 10000) % 100)){
                        strcpy(auxnombre,conj[j].nombre);
                        auxfecha=conj[i].fecha;
                        strcpy(conj[j].nombre,conj[j+1].nombre);
                        conj[j].fecha=conj[j+1].fecha;
                        strcpy(conj[j+1].nombre,auxnombre);
                        conj[j+1].fecha=auxfecha;
                    }
                    else if(((conj[j].fecha / 10000) % 100) == ((conj[j+1].fecha / 10000) % 100)){
                        if((conj[j].fecha / 1000000) > (conj[j+1].fecha / 1000000)){
                            strcpy(auxnombre,conj[j].nombre);
                            auxfecha=conj[i].fecha;
                            strcpy(conj[j].nombre,conj[j+1].nombre);
                            conj[j].fecha=conj[j+1].fecha;
                            strcpy(conj[j+1].nombre,auxnombre);
                            conj[j+1].fecha=auxfecha;
                        }
                    }
                }
            }
       }

    cout<<"\n\nOrden por fechas\n";
    for(i=0;i<n;i++){
        cout<<"Nombre: "<<conj[i].nombre<<"  Fecha: "<<conj[i].fecha<<endl;
    }
    return;
}