#include <iostream>
#include<cstring>

using namespace std;

struct alumnos{
    int legajo,codpostal,tele,año;
    char nombre[30],domicilio[20],codigo;
};

struct info{
    int legajo,codpostal,tele,año;
    char nombre[30],domicilio[20];
};

void contarcodigos(int&,int&,FILE*,alumnos[]);
void cargaralumnos(int&,int&,FILE*,info[],alumnos[]);
void burbujeo(int&,info[]);
void mostrardatos(int&,info[],FILE*);


int main(){
    FILE* f11 = fopen("ALUMNOS.dat","rb+");
    FILE* f12 = fopen("ALUMACTU.dat","wb+");


    fseek(f11,0,SEEK_END);
    int tamaño = ftell(f11)/sizeof(alumnos);
    fseek(f11,0,SEEK_SET);

    int n=0;

    alumnos al1[tamaño];
    contarcodigos(tamaño,n,f11,al1);
    info al[n];
    cargaralumnos(n,tamaño,f11,al,al1);
    burbujeo(n,al);
    mostrardatos(n,al,f12);
    
    fclose(f11);
    fclose(f12);

    return 0;
}

void contarcodigos(int& tamaño,int& n,FILE* f11,alumnos al1[]){
    alumnos aux;
    int i=0;
    while(fread(&aux,sizeof(alumnos),1,f11)){
        al1[i] = aux;
        if(aux.codigo == 'A' || aux.codigo == 'M'){
            n++;
        }
        i++;
    }

    fseek(f11,0,SEEK_SET);

    return;
}


void cargaralumnos(int& n,int& tamaño,FILE* f11,info al[],alumnos al1[]){
    char par;
    int i=0,j=0,k=0,cant;

    while(fread(&al1[i],sizeof(alumnos),1,f11)){
        if(al1[i].codigo == 'A'){
            al[j].legajo = al1[i].legajo;
            strcpy(al[j].nombre,al1[i].nombre);
            strcpy(al[j].domicilio,al1[i].domicilio);
            al[j].codpostal = al1[i].codpostal;
            al[j].tele = al1[i].tele;
            al[j].año = al1[i].año;
            j++;
        }
        if(al1[i].codigo == 'M'){
            cout<<"\n¿Cuántos parámetros desea modificar del alumno "<<i+1<<"?: "; cin>>cant;
            for(k=0;k<cant;k++){
                cout<<"\nIndique qué parámetro desea modificar('L' = Legajo, 'N' = Nombre, 'D' = Domicilio, 'C' = Código Postal, 'T' = Teléfono, 'A' = Año) del alumno "<<i+1<<": "; cin>>par;
                switch(par){
                case 'L': cout<<"\nLegajo "<<i+1<<": "; cin>>al1[i].legajo; break;
                case 'N': cout<<"\nNombre "<<i+1<<": "; cin>>al1[i].nombre; break;
                case 'D': cout<<"\nDomicilio "<<i+1<<": "; cin>>al1[i].domicilio; break;
                case 'C': cout<<"\nCódigo Postal "<<i+1<<": "; cin>>al1[i].codpostal; break;
                case 'T': cout<<"\nTeléfono "<<i+1<<": "; cin>>al1[i].tele; break;
                case 'A': cout<<"\nAño "<<i+1<<": "; cin>>al1[i].año; break;
                }
            }
            al[j].legajo = al1[i].legajo;
            strcpy(al[j].nombre,al1[i].nombre);
            strcpy(al[j].domicilio,al1[i].domicilio);
            al[j].codpostal = al1[i].codpostal;
            al[j].tele = al1[i].tele;
            al[j].año = al1[i].año;
            j++;
        }
        i++;
    }

    return;
}

    
void burbujeo(int& n,info al[]){
    int i,j;
    info auxx;

    for(i=1;i<n;i++){
        for(j=1;j<=n-i;j++){
            if(al[j-1].legajo > al[j].legajo){
                auxx = al[j-1];
                al[j-1] = al[j];
                al[j] = auxx;
            }
        }
    }

    return;
}
    
void mostrardatos(int& n,info al[],FILE* f12){
    int i=0;

    for(i=0;i<n;i++){
        fwrite(&al[i],sizeof(info),1,f12);
    }


    fseek(f12,0,SEEK_SET);

    cout<<"\nDATOS DE ALUMNOS ACTUALIZADOS";
    while(fread(&al[i],sizeof(info),1,f12)){
        cout<<"\n\nLegajo "<<i+1<<": "<<al[i].legajo;
        cout<<"\nNombre "<<i+1<<": "<<al[i].nombre;
        cout<<"\nDomicilio "<<i+1<<": "<<al[i].domicilio;
        cout<<"\nCódigo Postal "<<i+1<<": "<<al[i].codpostal;
        cout<<"\nTeléfono "<<i+1<<": "<<al[i].tele;
        cout<<"\nAño "<<i+1<<": "<<al[i].año;
        i++;
    }

    return;
}   