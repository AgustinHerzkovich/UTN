#include <iostream>

using namespace std;

struct articulos{
    int cod,talle;
    float precio;
};

struct ventas{
    int unid,cod,talle;
};

void cargar_datos(articulos[],ventas[],FILE*,FILE*);
void burbujeo(int&,int&,articulos[],ventas[]);
void informe_A(int&,int&,articulos[],ventas[]);
void informe_B(int&,int&,articulos[],ventas[]);


int main(){
    FILE* f14 = fopen("Articulos.dat","rb+");
    FILE *f15 = fopen("Facturas.dat","rb+");

    //obtener tamaño
    fseek(f14,0,SEEK_END);
    fseek(f15,0,SEEK_END);
    int tam1 = ftell(f14)/sizeof(articulos);
    int tam2 = ftell(f15)/sizeof(ventas);
    fseek(f14,0,SEEK_SET);
    fseek(f15,0,SEEK_SET);

    articulos art[tam1];
    ventas ven[tam2];

    cargar_datos(art,ven,f14,f15);
    burbujeo(tam1,tam2,art,ven);
    informe_A(tam1,tam2,art,ven);
    informe_B(tam1,tam2,art,ven);

    fclose(f14);
    fclose(f15);

    return 0;
}

void cargar_datos(articulos art[],ventas ven[],FILE* f14,FILE* f15){
    int i=0,j=0;
    articulos aux1;
    ventas aux2;
    while(fread(&aux1,sizeof(articulos),1,f14)){
        art[i] = aux1;
        i++;
    }

    while(fread(&aux2,sizeof(ventas),1,f15)){
        ven[j] = aux2;
        j++;
    }

    return;
}


void burbujeo(int& tam1,int& tam2,articulos art[],ventas ven[]){
    int i,j;
    articulos aux1;
    ventas aux2;
    for(i=1;i<tam1;i++){
        for(j=1;j<=tam1-i;j++){
            if((art[j-1].cod > art[j].cod) || (art[j-1].cod == art[j].cod && art[j-1].talle > art[j].talle)){
                aux1 = art[j-1];
                art[j-1] = art[j];
                art[j] = aux1;
            }
        }
    }

    for(i=1;i<tam2;i++){
        for(j=1;j<=tam2-i;j++){
            if((ven[j-1].cod > ven[j].cod) || (ven[j-1].cod == ven[j].cod && ven[j-1].talle > ven[j].talle)){
                aux2 = ven[j-1];
                ven[j-1] = ven[j];
                ven[j] = aux2;
            }
        }
    }
    
    return;
}


void informe_A(int& tam1,int& tam2,articulos art[],ventas ven[]){
    int i,j,k=0;
    float total[tam2];
    for(i=0;i<tam2;i++){
        for(j=0;j<tam1;j++){
            if(ven[i].cod == art[j].cod){
                if(ven[i].unid > 3){
                    total[k] = ((ven[i].unid * art[j].precio) - ((ven[i].unid * art[j].precio)*0.1) + ((ven[i].unid * art[j].precio)*0.21));
                    k++;
                }
                else{
                    total[k] = ((ven[i].unid * art[j].precio) + ((ven[i].unid * art[j].precio)*0.21));
                    k++;
                }
            }
            else{

            }
        }
    }

    cout<<"\nINFORME A";
    for(i=0;i<tam2;i++){
        cout<<"\n\nPrecio de la venta ["<<i+1<<"]: "<<total[i];
    }

    return;
}


void informe_B(int& tam1,int& tam2,articulos art[],ventas ven[]){
    int i,j,contador=0,total=0;

    for(i=0;i<tam2;i++){
        total += ven[i].unid;
    }

    cout<<"\n\nINFORME B";

    for(i=0;i<tam1;i++){
        cout<<"\n\nCódigo '"<<art[i].cod<<"'";
        contador=0;
        for(j=0;j<tam2;j++){
            if(art[i].cod == ven[j].cod){
                contador+=ven[j].unid;
            }
        }
        cout<<"\nTotal de unidades vendidas: "<<contador;
    }
    cout<<"\n\nTotal general de ventas: "<<total<<"\n";
    
    return;
}