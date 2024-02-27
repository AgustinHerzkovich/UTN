#include <iostream>
#include <cstring>

using namespace std;

struct pacientes{
    int id,edad;
    char nombre[50+1],apellido[50+1],diagnostico[99+1];
};

struct medicamentos{
    int ean,dosis;
    char nombre[50+1];
};

struct prescripciones{
    int id,ean,intervalo,hora;
};

struct listado{
    int id,ean,dosis,hora;
    char nombre[50+1],apellido[50+1],nombreg[50+1];
};

struct listadou{
    int id;
    char nombre[50+1],apellido[50+1];
};

int tamaño1(FILE*);
int tamaño2(FILE*);
int tamaño3(FILE*);
void cargar_vector1(pacientes[],FILE*);
void cargar_vector2(medicamentos[],FILE*);
void cargar_vector3(prescripciones[],FILE*);
void burbuja_1(int,pacientes[]);
int tamaño4(int,int,pacientes[],prescripciones[]);
void rellenar_listado(int,int,int,pacientes[],prescripciones[],medicamentos[],listado[]);
void burbuja_2(int,listado[]);
void mostrar_listado(int,listado[]);
void rellenar_nolistado(int,int,pacientes[],prescripciones[],listadou[]);
void mostrar_nolistado(int,listadou[]);

int main(){
    FILE* f1 = fopen("pacientes.dat","rb");
    FILE* f2 = fopen("medicamentos.dat","rb");
    FILE* f3 = fopen("prescripciones.dat","rb");

    int t1 = tamaño1(f1);
    int t2 = tamaño2(f2);
    int t3 = tamaño3(f3);

    pacientes pac[t1];
    medicamentos mec[t2];
    prescripciones prec[t3];

    cargar_vector1(pac,f1);
    cargar_vector2(mec,f2);
    cargar_vector3(prec,f3);
    burbuja_1(t1,pac);

    int t4 = tamaño4(t1,t3,pac,prec);
    listado list[t4];
    rellenar_listado(t1,t2,t3,pac,prec,mec,list);
    burbuja_2(t4,list);
    mostrar_listado(t4,list);  
    listadou listx[t4];
    rellenar_nolistado(t1,t3,pac,prec,listx);
    mostrar_nolistado(t4,listx);


    fclose(f1);
    fclose(f2);
    fclose(f3);


    return 0;
}

int tamaño1(FILE* f1){
    fseek(f1,0,SEEK_END);
    int t1 = ftell(f1)/sizeof(pacientes);
    fseek(f1,0,SEEK_SET);

    return t1;
}

int tamaño2(FILE* f2){
    fseek(f2,0,SEEK_END);
    int t2 = ftell(f2)/sizeof(medicamentos);
    fseek(f2,0,SEEK_SET);

    return t2;

}

int tamaño3(FILE* f3){
    fseek(f3,0,SEEK_END);
    int t3 = ftell(f3)/sizeof(prescripciones);
    fseek(f3,0,SEEK_SET);

    return t3;
}

void cargar_vector1(pacientes pac[],FILE* f1){
    int i=0;
    pacientes aux1;
    while(fread(&aux1,sizeof(pacientes),1,f1)){
        pac[i] = aux1;
        i++;
    }

    return;
}

void cargar_vector2(medicamentos mec[],FILE* f2){
    int j=0;
    medicamentos aux2;
    while(fread(&aux2,sizeof(medicamentos),1,f2)){
        mec[j] = aux2;
        j++;
    }

    return;
}

void cargar_vector3(prescripciones prec[],FILE* f3){
    int k=0;
    prescripciones aux3;
    while(fread(&aux3,sizeof(prescripciones),1,f3)){
        prec[k] = aux3;
        k++;
    }

    return;
}

void burbuja_1(int t1,pacientes pac[]){
    int i,j;
    pacientes aux1;
    for(i=1;i<t1;i++){
        for(j=1;j<=t1-i;j++){
            if(pac[j-1].id > pac[j].id){
                aux1 = pac[j-1];
                pac[j-1] = aux1;
                pac[j] = aux1;
            }
        }
    }

    return;
}

int tamaño4(int t1,int t3,pacientes pac[],prescripciones prec[]){
    int i,j,cont=0;
    for(i=0;i<t1;i++){
        for(j=0;j<t3;j++){
            if(pac[i].id == prec[j].id){
                cont++;
            }
        }
    }

    return cont;
}

void rellenar_nolistado(int t1,int t3,pacientes pac[],prescripciones prec[],listadou listx[]){
    int i,j,k=0;
    for(i=0;i<t1;i++){
        for(j=0;j<t3;j++){
            if(pac[i].id == prec[j].id){
                break;
            }
            else{
                listx[k].id = pac[i].id;
                strcpy(listx[k].nombre,pac[i].nombre);
                strcpy(listx[k].nombre,pac[i].apellido);
                k++;
            }
        }
    }

    return;
}


void rellenar_listado(int t1,int t2,int t3,pacientes pac[],prescripciones prec[],medicamentos mec[],listado list[]){
    int i,j,z,k=0;
    for(i=0;i<t1;i++){
        for(j=0;j<t2;j++){
            for(z=0;z<t3;z++){
                if(pac[i].id == prec[j].id){
                    if(prec[j].ean == mec[z].ean){
                        list[k].id = prec[j].id;
                        strcpy(list[k].nombre,pac[i].nombre);
                        strcpy(list[k].apellido,pac[i].apellido);
                        list[k].ean = prec[j].ean;
                        strcpy(list[k].nombreg,mec[z].nombre);
                        list[k].dosis = mec[z].dosis;
                        list[k].hora = prec[j].hora;
                        k++;
                    }
                }
            }
        }
    }

    return;
}

void burbuja_2(int t4,listado list[]){
    int i,j;
    listado aux;
    for(i=1;i<t4;i++){
        for(j=1;j<=t4-i;j++){
            if(list[j-1].id > list[j].id || (list[j-1].id == list[j].id && list[j-1].hora > list[j].hora)){
                aux = list[j-1];
                list[j-1] = list[j];
                list[j] = aux;
            }
        }
    }

    return;
}

void mostrar_listado(int t4,listado list[]){
    int i;
    cout<<"\nPACIENTES CON PRESCRIPCIÓN";
    for(i=0;i<t4;i++){
        cout<<"\n\nID: "<<list[i].id;
        cout<<"\nNombre: "<<list[i].nombre;
        cout<<"\nApellido: "<<list[i].apellido;
        cout<<"\nEAN: "<<list[i].ean;
        cout<<"\nNombre genérico: "<<list[i].nombreg;
        cout<<"\nDosis: "<<list[i].dosis;
        cout<<"\nHora: "<<list[i].hora;
    }

    return;
}

void mostrar_nolistado(int t4,listadou listx[]){
    int i=0;
    cout<<"\n\nPACIENTES SIN PRESCRIPCIÓN";
    for(i=0;i<t4;i++){
        if(strcmp(listx[i].nombre,"0")!=0){
            cout<<"\n\nID: "<<listx[i].id;
            cout<<"\nNombre: "<<listx[i].nombre;
            cout<<"\nApellido: "<<listx[i].apellido;
        } 
        cout<<"\n";
    }

    return;
}