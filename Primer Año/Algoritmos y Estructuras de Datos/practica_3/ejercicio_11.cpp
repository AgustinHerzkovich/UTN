#include <iostream>

using namespace std;

struct datos{
    int modelo;
    char color;
};

int obtener_tamaño(FILE*);
void cargar_vector(datos[],FILE*);
void burbujeo_modelos(int&,datos[]);
void total_modelos(int&,int&,datos[]);
void burbujeo_colores(int&,datos[]);
void total_colores(int&,int&,datos[]);
void total_totales(int&);


int main(){
    FILE* f13 = fopen("CALZADOS.dat","rb+");

    int total=0;
    int tam = obtener_tamaño(f13);
    datos dat[tam];
    cargar_vector(dat,f13);
    burbujeo_modelos(tam,dat);
    total_modelos(tam,total,dat);
    burbujeo_colores(tam,dat);
    total_colores(tam,total,dat);
    total_totales(total);

    fclose(f13);

    return 0;
}

int obtener_tamaño(FILE* f13){
    fseek(f13,0,SEEK_END);
    int tam = ftell(f13)/sizeof(datos);
    fseek(f13,0,SEEK_SET);

    return tam;
}

void cargar_vector(datos dat[],FILE* f13){
    int i=0;
    datos aux;
    while(fread(&aux,sizeof(datos),1,f13)){
        dat[i] = aux;
        i++;
    }

    return;
}

void burbujeo_modelos(int& tam,datos dat[]){
    int i,j;
    datos aux;
    for(i=1;i<tam;i++){
        for(j=1;j<=tam-i;j++){
            if(dat[j-1].modelo > dat[j].modelo){
                aux = dat[j-1];
                dat[j-1] = dat[j];
                dat[j] = aux;
            }
        }
    }

    return;
}

void total_modelos(int& tam,int& total,datos dat[]){
    int i=0,contador,actual;
    cout<<"INFORME\n";
    while(i<tam){
        actual = dat[i].modelo;
        cout<<"\nTotal de modelo "<<actual<<": ";
        contador=0;
        while(i<tam && actual==dat[i].modelo){
            contador++;
            total++;
            i++;
        }
        cout<<contador;
    }

    return;
}

void burbujeo_colores(int& tam,datos dat[]){
    int i,j;
    datos aux;
    for(i=1;i<tam;i++){
        for(j=1;j<=tam-i;j++){
            if(dat[j-1].color > dat[j].color){
                aux = dat[j-1];
                dat[j-1] = dat[j];
                dat[j] = aux;
            }
        }
    }

    return;
}

void total_colores(int& tam,int& total,datos dat[]){
    int i=0,contador;
    char actualc;
    cout<<endl;
    while(i<tam){
        actualc = dat[i].color;
        cout<<"\nTotal de color "<<actualc<<": ";
        contador=0;
        while(i<tam && actualc==dat[i].color){
            contador++;
            total++;
            i++;
        }
        cout<<contador;
    }

    return;
}

void total_totales(int& total){
    cout<<"\n\nEl total de ventas es: "<<total;
    return;
}