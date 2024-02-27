#include <iostream>
#include <cstring>

using namespace std;

struct info{
    int nroarticulo,cantstock,nroprovee;
    char descrip[19];
    float preciounid;
};

void cargardatos(info[],FILE*);
void ordenararticulo(int,info[],FILE*);
void ordenardescripcion(int,info[],FILE*);
void ordenarprovcrecyartcrec(int,info[],FILE*);
void ordenarprovcrecyartdecrec(int,info[],FILE*);

int main(){ 
    FILE* f7 = fopen("PRECIOS.DAT","rb+");

    fseek(f7,0,SEEK_END);
    int n = ftell(f7)/sizeof(info);
    info infos[n];
    fseek(f7,0,SEEK_SET);

    cargardatos(infos,f7);
    ordenararticulo(n,infos,f7);
    ordenardescripcion(n,infos,f7);
    ordenarprovcrecyartcrec(n,infos,f7);
    ordenarprovcrecyartdecrec(n,infos,f7);

    fclose(f7);

    return 0;
}

void cargardatos(info infos[],FILE* f7){
    info aux;
    int i=0;
    while(fread(&aux,sizeof(info),1,f7)){
        infos[i] = aux;
        i++;
    }
    fseek(f7,0,SEEK_SET);
    fflush(f7);

    return;
}

void ordenararticulo(int n,info infos[],FILE* f7){
    int i=0,j=0;
    info aux;

    for(i=1;i<n;i++){
        for(j=1;j<=n-i;j++){
            if(infos[j-1].nroarticulo > infos[j].nroarticulo){
                aux = infos[j-1];
                infos[j-1] = infos[j];
                infos[j] = aux;
            }
        }
    }

    for(i=0;i<n;i++){
        fwrite(&infos[i],sizeof(info),1,f7);
    }

    fseek(f7,0,SEEK_SET);

    cout<<"\n\nORDEN POR NÚMERO DE ARTÍCULO CRECIENTE";
    while(fread(&infos[i],sizeof(info),1,f7)){
        cout<<"\n\nNúmero de Artículo: "<<infos[i].nroarticulo;
        cout<<"\nDescripción del Artículo: "<<infos[i].descrip;
        cout<<"\nPrecio por Unidad: "<<infos[i].preciounid;
        cout<<"\nCantidad en Stock: "<<infos[i].cantstock;
        cout<<"\nNúmero de Proveedor: "<<infos[i].nroprovee;
        i++;
    }
    fseek(f7,0,SEEK_SET);
    fflush(f7);

    return;
}

void ordenardescripcion(int n,info infos[],FILE* f7){
    int i=0,j=0;
    info aux;

    for(i=1;i<n;i++){
        for(j=1;j<=n-i;j++){
            if(strcmp(infos[j-1].descrip,infos[j].descrip) >= 1){
                aux = infos[j-1];
                infos[j-1] = infos[j];
                infos[j] = aux;
            }
        }
    }

    for(i=0;i<n;i++){
        fwrite(&infos[i],sizeof(info),1,f7);
    }

    fseek(f7,0,SEEK_SET);

    cout<<"\n\nORDEN POR DESCRIPCIÓN ALFABÉTICA CRECIENTE";
    while(fread(&infos[i],sizeof(info),1,f7)){
        cout<<"\n\nNúmero de Artículo: "<<infos[i].nroarticulo;
        cout<<"\nDescripción del Artículo: "<<infos[i].descrip;
        cout<<"\nPrecio por Unidad: "<<infos[i].preciounid;
        cout<<"\nCantidad en Stock: "<<infos[i].cantstock;
        cout<<"\nNúmero de Proveedor: "<<infos[i].nroprovee;
        i++;
    }
    fseek(f7,0,SEEK_SET);
    fflush(f7);

    return;
}

void ordenarprovcrecyartcrec(int n,info infos[],FILE* f7){
    int i=0,j=0;
    info aux;

    for(i=1;i<n;i++){
        for(j=1;j<=n-i;j++){
            if(infos[j-1].nroprovee > infos[j].nroprovee){
                if(infos[j-1].nroarticulo > infos[j].nroarticulo){
                    aux = infos[j-1];
                    infos[j-1] = infos[j];
                    infos[j] = aux;
                }
            }
        }
    }

    for(i=0;i<n;i++){
        fwrite(&infos[i],sizeof(info),1,f7);
    }

    fseek(f7,0,SEEK_SET);

    cout<<"\n\nORDEN POR NÚMERO DE PROVEEDOR CRECIENTE Y NÚMERO DE ARTÍCULO CRECIENTE";
    while(fread(&infos[i],sizeof(info),1,f7)){
        cout<<"\n\nNúmero de Artículo: "<<infos[i].nroarticulo;
        cout<<"\nDescripción del Artículo: "<<infos[i].descrip;
        cout<<"\nPrecio por Unidad: "<<infos[i].preciounid;
        cout<<"\nCantidad en Stock: "<<infos[i].cantstock;
        cout<<"\nNúmero de Proveedor: "<<infos[i].nroprovee;
        i++;
    }
    fseek(f7,0,SEEK_SET);
    fflush(f7);

    return;
}

void ordenarprovcrecyartdecrec(int n,info infos[],FILE* f7){
    int i=0,j=0;
    info aux;

    for(i=1;i<n;i++){
        for(j=1;j<=n-i;j++){
            if(infos[j-1].nroprovee > infos[j].nroprovee){
                if(infos[j-1].nroarticulo < infos[j].nroarticulo){
                    aux = infos[j-1];
                    infos[j-1] = infos[j];
                    infos[j] = aux;
                }
            }
        }
    }

    for(i=0;i<n;i++){
        fwrite(&infos[i],sizeof(info),1,f7);
    }

    fseek(f7,0,SEEK_SET);

    cout<<"\n\nORDEN POR NÚMERO DE PROVEEDOR CRECIENTE Y NÚMERO DE ARTÍCULO DECRECIENTE";
    while(fread(&infos[i],sizeof(info),1,f7)){
        cout<<"\n\nNúmero de Artículo: "<<infos[i].nroarticulo;
        cout<<"\nDescripción del Artículo: "<<infos[i].descrip;
        cout<<"\nPrecio por Unidad: "<<infos[i].preciounid;
        cout<<"\nCantidad en Stock: "<<infos[i].cantstock;
        cout<<"\nNúmero de Proveedor: "<<infos[i].nroprovee;
        i++;
    }
    cout<<endl;
    fseek(f7,0,SEEK_SET);
    fflush(f7);

    return;
}