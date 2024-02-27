#include <iostream>
#include <cstring>

using namespace std;

struct info{
    int nroarticulo,cantstock,nroprovee;
    char descrip[19];
    float preciounid;
};

void ingresardatos(int,FILE*);

int main(){ 
    FILE* f7;

    int n;

    cout<<"\nIngrese cantidad de registros: "; cin>>n;

    ingresardatos(n,f7);

    return 0;
}

void ingresardatos(int n,FILE* f7){
    f7 = fopen("PRECIOS.DAT","wb");
    int i;
    info infos;
    
    for(i=0;i<n;i++){
        cout<<"\n\nNúmero de Artículo: "; cin>>infos.nroarticulo;
        cout<<"\nDescripción del Artículo: "; cin>>infos.descrip;
        cout<<"\nPrecio por Unidad: "; cin>>infos.preciounid;
        cout<<"\nCantidad en Stock: "; cin>>infos.cantstock;
        cout<<"\nNúmero de Proveedor: "; cin>>infos.nroprovee;
        fwrite(&infos,sizeof(info),1,f7);
    }

    fclose(f7);

    return;
}