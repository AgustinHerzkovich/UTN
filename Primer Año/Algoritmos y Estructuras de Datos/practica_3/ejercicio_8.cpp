#include <iostream>
#include <cstring>

using namespace std;

struct info1{
    int codvuelo,cantdispo;
};

struct info2{
    int codsolicitado,cantsolic,dni;
    char nombre[30];
};

int tamaño1(FILE*);
int tamaño2(FILE*);
void rellenar_vector_1(info2[],FILE*);
void rellenar_vector_2(info1[],FILE*);
void mostrar_1(int,info2[]);
void mostrar_2(int,int,info1[],info2[]);

int main(){
    FILE* f8=fopen("INFODEVUELOS.DAT","rb+");
    FILE* f9=fopen("INFODECOMPRADORES.DAT","rb+");
    
    
    int tam1 = tamaño1(f8);
    int tam2 = tamaño2(f9);
    

    info1 info[tam1];
    info2 infa[tam2];

    rellenar_vector_1(infa,f9);
    rellenar_vector_2(info,f8);
    mostrar_1(tam2,infa);
    mostrar_2(tam1,tam2,info,infa);  

    fclose(f8);
    fclose(f9);

    return 0;
}

int tamaño1(FILE* f8){
    fseek(f8,0,SEEK_END);
    int tamaño1 = ftell(f8)/sizeof(info1);
    fseek(f8,0,SEEK_SET);

    return tamaño1;
}


int tamaño2(FILE* f9){
    fseek(f9,0,SEEK_END);
    int tamaño2 = ftell(f9)/sizeof(info2);
    fseek(f9,0,SEEK_SET);

    return tamaño2;
}


void rellenar_vector_1(info2 infa[],FILE* f9){
    int i=0;
    info2 aux2;
    while(fread(&aux2,sizeof(info2),1,f9)){
        infa[i] = aux2;
        i++;
    }
    fseek(f9,0,SEEK_SET);

    return;
}

void rellenar_vector_2(info1 info[],FILE* f8){
    int i=0;
    info1 aux1;
    while(fread(&aux1,sizeof(info1),1,f8)){
        info[i]=aux1;
        i++;
    }
    fseek(f8,0,SEEK_SET);

    return;
}

void mostrar_1(int tam2,info2 infa[]){
    int i;
    cout<<"\n\nDATOS DE COMPRADORES";
    for(i=0;i<tam2;i++){
                cout<<"\n\nDNI: "<<infa[i].dni;
                cout<<"\nApellido y Nombre: "<<infa[i].nombre;
                cout<<"\nCantidad de Pasajes: "<<infa[i].cantsolic;
                cout<<"\nCódigo de Vuelo: "<<infa[i].codsolicitado;
    }

    return;
}

void mostrar_2(int tam1,int tam2,info1 info[],info2 infa[]){
    int i=0,j=0,actual,pasajes=0,cont=0;
    cout<<"\n\nDATOS DE VUELOS";
    while(i<tam1){
        actual = info[i].codvuelo;
        cout<<"\n\nCódigo de Vuelo: "<<actual;
        cont=0;
        while(i<tam1 && actual == info[i].codvuelo){
            for(j=0;j<tam2;j++){
                if(info[i].codvuelo == infa[j].codsolicitado && infa[j].cantsolic <= info[i].cantdispo){
                    cout<<"\nPasajes Libres: "<<info[i].cantdispo - infa[j].cantsolic;
                    cout<<"\nPasajes no Vendidos: "<<pasajes;
                }
            }
            for(j=0;j<tam2;j++){
                if(info[i].codvuelo == infa[j].codsolicitado && infa[j].cantsolic > info[i].cantdispo){
                    cout<<"\nPasajes Libres: "<<info[i].cantdispo;
                    cout<<"\nPasajes no Vendidos: "<<infa[j].cantsolic;
                }
            }
            for(j=0;j<tam2;j++){
                if(info[i].codvuelo != infa[j].codsolicitado){
                    cont++;
                }
            }
            if(cont == tam2){
                    cout<<"\nPasajes Libres: "<<info[i].cantdispo;
                    cout<<"\nPasajes no Vendidos: "<<pasajes;
                }
            i++;
        }
            
    }
    return;
}


