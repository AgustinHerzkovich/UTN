#include <iostream>
#include <cstring>

using namespace std;

struct datos1{
    int nrodestino;
    float distancia;
};

struct datos2{
    char patente[6];
    int nrodestino,nrochofer;
};

struct patentes{
    char patente[6];
};

void cargar_datos(datos1[],datos2[],FILE*,FILE*);
void burbujeo(int,int,datos1[],datos2[]);
void corte_de_control(int,datos2[]);
void chofer_con_menos_km(int,datos1[],datos2[],FILE*,FILE*);
void patentes_con_destino_116(datos2[],patentes[],FILE*);

int main(){
        FILE* f16 = fopen("DESTINOS.dat","rb+");
        FILE* f17 = fopen("VIAJES.dat","rb+");

        fseek(f16,0,SEEK_END);
        fseek(f17,0,SEEK_END);

        int tamaño1 = ftell(f16)/sizeof(datos1);
        int tamaño2 = ftell(f17)/sizeof(datos2);

        fseek(f16,0,SEEK_SET);
        fseek(f17,0,SEEK_SET);

        datos1 dat1[tamaño1];
        datos2 dat2[tamaño2];
        patentes pat[tamaño2];

        cargar_datos(dat1,dat2,f16,f17);
        burbujeo(tamaño1,tamaño2,dat1,dat2);
        corte_de_control(tamaño2,dat2);
        chofer_con_menos_km(tamaño2,dat1,dat2,f16,f17);
        patentes_con_destino_116(dat2,pat,f17);

        fclose(f16);
        fclose(f17);

    return 0;
}

void cargar_datos(datos1 dat1[],datos2 dat2[],FILE* f16,FILE* f17){
    int i=0,j=0;
    datos1 aux1;
    datos2 aux2;
    
    while(fread(&aux1,sizeof(datos1),1,f16)){
        dat1[i]=aux1;
        i++;
    }

    while(fread(&aux2,sizeof(datos2),1,f17)){
        dat2[j]=aux2;
        j++;
    }

    fseek(f16,0,SEEK_SET);
    fseek(f17,0,SEEK_SET);

    return;
}

void burbujeo(int tamaño1,int tamaño2,datos1 dat1[],datos2 dat2[]){
    int i=0,j=0;
    datos1 aux1;
    datos2 aux2;
    for(i=1;i<tamaño1;i++){
            for(j=1;j<=tamaño1-i;j++){
                if(dat1[j-1].nrodestino > dat1[j].nrodestino){
                    aux1 = dat1[j-1];
                    dat1[j-1] = dat1[j];
                    dat1[j] = aux1;
                }
            }
        }

        for(i=1;i<tamaño2;i++){
            for(j=1;j<=tamaño2-i;j++){
                if(dat2[j-1].nrodestino > dat2[j].nrodestino){
                    aux2 = dat2[j-1];
                    dat2[j-1] = dat2[j];
                    dat2[j] = aux2;
                }
            }
        }
    return;
}

void corte_de_control(int tamaño2,datos2 dat2[]){
    int destinoactual,contador=0,i=0;
        while(i<tamaño2){
            destinoactual = dat2[i].nrodestino;
            cout<<"\n\nDestino "<<destinoactual;
            contador=0;
            while(i<tamaño2 && destinoactual == dat2[i].nrodestino){
                contador++;
                i++;
            }
            if(contador>0){
                cout<<"\nTotal de viajes con este destino: "<<contador;
            }
        }
    return;
}

void chofer_con_menos_km(int tamaño2,datos1 dat1[],datos2 dat2[],FILE* f16,FILE* f17){
    int k=0,cont=0,num,i=0,j=0,menor=dat1[0].distancia;

    int vec1[tamaño2];

    while(fread(&dat1[i],sizeof(datos1),1,f16)){
        if(dat1[i].distancia < menor){
            menor = dat1[i].distancia;
            num = dat1[i].nrodestino;
        }
        i++;
    }

    while(fread(&dat2[j],sizeof(datos2),1,f17)){
        if(dat2[j].nrodestino == num){
            vec1[k] = dat2[j].nrochofer;
            k++;
            cont++;
        }
        j++;
    }

    cout<<"\n\nNúmero/s de chofer/es con menor cantidad de KM: ";
    for(i=0;i<cont;i++){
        cout<<vec1[i]<<"  ";
    }

    fseek(f16,0,SEEK_SET);
    fseek(f17,0,SEEK_SET);

    return;
}

void patentes_con_destino_116(datos2 dat2[],patentes pat[],FILE* f17){
    int i=0,k=0,cont=0;

    while(fread(&dat2[i],sizeof(datos2),1,f17)){
        if(dat2[i].nrodestino == 116){
            strcpy(pat[k].patente,dat2[i].patente);
            k++;
            cont++;
        }
    }
    cout<<"\n\nPatentes que viajaron al destino 116: ";
    for(i=0;i<cont;i++){
        cout<<pat[i].patente<<"  ";
    }
    if(cont==0){
        cout<<"Ninguna";
    }
    cout<<endl;

    return;
}