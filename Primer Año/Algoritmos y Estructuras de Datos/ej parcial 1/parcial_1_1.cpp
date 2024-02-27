#include <iostream>
#include <cstring>

using namespace std;

struct vendedores{
    int idvendedor;
    char apeynom[20+1];
};

struct modelos{
    char idmodelo[4+1],descripcion[20+1];
};

struct ventas{
    char idmodelo[4+1],cliente[20+1];
    int fecha,idvendedor;
};


void OrdenarVectorVendedores(int,vendedores[]);
void OrdenarVectorModelos(int,modelos[]);
void EmitirListado(int,int,int,ventas[],vendedores[],modelos[]);


int main(){
    FILE* f1 = fopen("VENDEDORES.dat","rb");
    FILE* f2 = fopen("MODELOS.dat","rb");
    FILE* f3 = fopen("VENTAS.dat","rb");

    fseek(f1,0,SEEK_END);
    fseek(f2,0,SEEK_END);
    fseek(f3,0,SEEK_END);
    int t1 = ftell(f1)/sizeof(vendedores);
    int t2 = ftell(f2)/sizeof(modelos);
    int t3 = ftell(f3)/sizeof(ventas);
    fseek(f1,0,SEEK_SET);
    fseek(f2,0,SEEK_SET);
    fseek(f3,0,SEEK_SET);

    vendedores ven[t1];
    modelos mo[t2];
    ventas ve[t3];
    vendedores aux1;
    modelos aux2;
    ventas aux3;

    int i=0,j=0,k=0;

    while(fread(&aux1,sizeof(vendedores),1,f1)){
        ven[i] = aux1;
        i++;
    }

    while(fread(&aux2,sizeof(modelos),1,f2)){
        mo[j] = aux2;
        j++;
    }

    while(fread(&aux3,sizeof(ventas),1,f3)){
        ve[k] = aux3;
        k++;
    }


    fseek(f1,0,SEEK_SET);
    fseek(f2,0,SEEK_SET);
    fseek(f3,0,SEEK_SET);


    OrdenarVectorVendedores(t1,ven);
    OrdenarVectorModelos(t2,mo);
    EmitirListado(t1,t2,t3,ve,ven,mo);


    fclose(f1);
    fclose(f2);
    fclose(f3);


    return 0;
}

void OrdenarVectorVendedores(int t1,vendedores ven[]){
    int i,j;
    vendedores aux;
    for(i=1;i<t1;i++){
        for(j=1;j<t1-i;j++){
            if(ven[j-1].idvendedor > ven[j].idvendedor){
                aux = ven[j-1];
                ven[j-1] = ven[j];
                ven[j] = aux;
            }
        }
    }
    return;
}


void OrdenarVectorModelos(int t2,modelos mo[]){
    int i,j;
    modelos aux;
    for(i=1;i<t2;i++){
        for(j=1;j<t2-i;j++){
            if(strcmp(mo[j-1].idmodelo,mo[j].idmodelo) == 1){
                aux = mo[j-1];
                mo[j-1] = mo[j];
                mo[j] = aux;
            }
        }
    }

    return;
}



void EmitirListado(int t1,int t2,int t3,ventas ve[],vendedores ven[],modelos mo[]){
    int i=0,j=0,actual,contador=0;
    while(i<t3){
        actual = ve[i].fecha;
        cout<<"\n\nFecha: "<<actual;
        contador=0;
        while(i<t3 && actual == ve[i].fecha){
            cout<<"\nCliente: "<<ve[i].cliente;
            for(j=0;j<t1;j++){
                if(ve[i].idvendedor == ven[j].idvendedor){
                    cout<<"\nNombre del vendedor: "<<ven[j].apeynom;
                }
            }
            for(j=0;j<t2;j++){
                if(strcmp(ve[i].idmodelo,mo[j].idmodelo) == 0){
                    cout<<"\nDescripción del modelo: "<<mo[j].descripcion;
                }
            }
            contador++;
            i++;
        }
        cout<<"\n\nCantidad de ventas del día: "<<contador;
    }
    cout<<endl;
    return;
}