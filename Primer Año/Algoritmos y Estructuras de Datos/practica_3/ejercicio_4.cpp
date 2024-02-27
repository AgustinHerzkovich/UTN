#include <iostream>
#include <cstring>

using namespace std;

struct dat{
    char nombre[20],apellido[20];
    int numlegajo,codigomateria,dia,mes,año;
};

struct datx{
    char nombre[20],apellido[20];
    int numlegajo;
};

int tamaño(FILE*);
void cargar_datos(dat[],FILE*);
void burbuja(int,dat[]);
void escribir(int,dat[],FILE*);
void leer(FILE*);

int main(){
    FILE* f2 = fopen("MATFINALES.DAT","rb");
    FILE* f3 = fopen("LEGAJOS.DAT","wb+");

    int tam = tamaño(f2);
    dat datos[tam]; //declaro el vector con ese tamaño
    cargar_datos(datos,f2);
    burbuja(tam,datos);
    escribir(tam,datos,f3);
    leer(f3);
   
    fclose(f2);
    fclose(f3);

    return 0;
}

int tamaño(FILE* f2){
    fseek(f2,0,SEEK_END); //mando el puntero al final
    int d = ftell(f2); //devuelve la cantidad que se desplazo desde el inicio
    int tam = d/sizeof(dat); //lo divido por el tamaño del registro
    fseek(f2,0,SEEK_SET); //mando el puntero al inicio nuevamente

    return tam;
}

void cargar_datos(dat datos[],FILE* f2){
    int z=0;
    dat var;
     while(fread(&var,sizeof(dat),1,f2)){
        if(var.numlegajo >= 80001 && var.numlegajo <= 110000){
            datos[z] = var;
            z++;
        }
    }

    return;
}

void burbuja(int tam,dat datos[]){
    int i,j;
    dat aux1;
     for(i=1;i<tam;i++){
        for(j=1;j<=tam-i;j++){
            if(datos[j-1].numlegajo > datos[j].numlegajo){
                aux1 = datos[j-1];
                datos[j-1] = datos[j];
                datos[j] = aux1;
            }
        }
    }

    return;
}

void escribir(int tam,dat datos[],FILE* f3){
    int z;
    datx datosx;
    for(z=0;z<tam;z++){
        fseek(f3,sizeof(datx)*(datos[z].numlegajo-80001),SEEK_SET); //copia los datos en la posicion correspondiente al num legajo(posicion unica y predecible)
        datosx.numlegajo = datos[z].numlegajo;
        strcpy(datosx.nombre,datos[z].nombre);
        strcpy(datosx.apellido,datos[z].apellido);
        fwrite(&datosx,sizeof(datx),1,f3);
    }
    fseek(f3,0,SEEK_SET);

    return;
}

void leer(FILE* f3){
    datx datosx;
     while(fread(&datosx,sizeof(datx),1,f3)){
        if(datosx.numlegajo !=0){
        cout<<"\n\nNombre: "<<datosx.nombre;
        cout<<"\nApellido: "<<datosx.apellido;
        cout<<"\nNúmero de Legajo: "<<datosx.numlegajo;
        }
    }

    return;
}