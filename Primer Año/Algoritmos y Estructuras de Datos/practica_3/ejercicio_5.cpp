#include <iostream>

using namespace std;

struct datos{
    int nrolegajo,codmateria;
    char apellidonombre[25];
};

int tamaño1();
int tamaño2();
void inscripciones_finales(int,datos[]);
void inscripciones_hoy(int,datos[]);
void burbuja_finales(int,datos[]);
void burbuja_hoy(int,datos[]);
void escribir_1(int,datos[],FILE*);
void escribir_2(int,datos[],FILE*);
void apareo(int,int,datos[],datos[],datos[]);
void imprimir(int,datos[],FILE*);

int main(){
    FILE* f4 = fopen("MAESTROFINALES.DAT","wb");
    FILE* f5 = fopen("DIAFINALES.BIN","wb");
    FILE* f6 = fopen("FINALESACT.DAT","wb+");

    int n = tamaño1();
    int m = tamaño2();
    int h = n+m;
    datos alumnos1[n];
    datos alumnos2[m];
    datos alumnos3[h];
    inscripciones_finales(n,alumnos1);
    inscripciones_hoy(m,alumnos2);
    burbuja_finales(n,alumnos1);
    burbuja_hoy(m,alumnos2);
    escribir_1(n,alumnos1,f4);
    escribir_2(m,alumnos2,f5);
    apareo(n,m,alumnos1,alumnos2,alumnos3);
    imprimir(h,alumnos3,f6);
 
    fclose(f4);
    fclose(f5);
    fclose(f6);

    return 0;
}

int tamaño1(){
    int n;
    cout<<"\nINGRESE LAS INSCRIPCIONES A EXÁMENES FINALES";
    cout<<"\nCantidad de alumnos: "; cin>>n;
    
    return n;
}

int tamaño2(){
    int m;
    cout<<"\nINGRESE LAS INSCRIPCIONES DEL DÍA DE HOY";
    cout<<"\nCantidad de alumnos: "; cin>>m;
    
    return m;
}

void inscripciones_finales(int n,datos alumnos1[]){
    int i;
    cout<<"\n\nINSCRIPCIONES FINALES";
    for(i=0;i<n;i++){
        cout<<"\n\nNombre: "; cin>>alumnos1[i].apellidonombre;
        cout<<"\nNúmero de Legajo: "; cin>>alumnos1[i].nrolegajo;
        cout<<"\nCódigo de Materia: "; cin>>alumnos1[i].codmateria;
    }

    return;
}


void inscripciones_hoy(int m,datos alumnos2[]){
    int i;
    cout<<"\n\nINSCRIPCIONES HOY";
    for(i=0;i<m;i++){
        cout<<"\n\nNombre: "; cin>>alumnos2[i].apellidonombre;
        cout<<"\nNúmero de Legajo: "; cin>>alumnos2[i].nrolegajo;
        cout<<"\nCódigo de Materia: "; cin>>alumnos2[i].codmateria;
    }

    return;
}


void burbuja_finales(int n,datos alumnos1[]){
    int i,j;
    datos aux;
    for(i=1;i<n;i++){
        for(j=1;j<=n-i;j++){
            if(alumnos1[j-1].codmateria > alumnos1[j].codmateria){
                aux = alumnos1[j-1];
                alumnos1[j-1] = alumnos1[j];
                alumnos1[j] = aux;
            }
        }
    }

    return;
}


void burbuja_hoy(int m,datos alumnos2[]){
    int i,j;
    datos aux;
    for(i=1;i<m;i++){
        for(j=1;j<=m-i;j++){
            if(alumnos2[j-1].codmateria > alumnos2[j].codmateria){
                aux = alumnos2[j-1];
                alumnos2[j-1] = alumnos2[j];
                alumnos2[j] = aux;
            }
        }
    }

    return;
}


void escribir_1(int n,datos alumnos1[],FILE* f4){
    int i;
    for(i=0;i<n;i++){
        fwrite(&alumnos1[i],sizeof(datos),1,f4);
    }
    fseek(f4,0,SEEK_SET);

    return;
}


void escribir_2(int m,datos alumnos2[],FILE* f5){
    int i;
    for(i=0;i<m;i++){
        fwrite(&alumnos2[i],sizeof(datos),1,f5);
    }
    fseek(f5,0,SEEK_SET);

    return;
}


void apareo(int n,int m,datos alumnos1[],datos alumnos2[],datos alumnos3[]){
    int i=0,j=0,k=0;
    while((i<n)&&(j<m)){
        if(alumnos1[i].codmateria < alumnos2[j].codmateria){
            alumnos3[k] = alumnos1[i];
            i++;
            k++;
        }
        else{
            alumnos3[k] = alumnos2[j];
            j++;
            k++;
        }
    }

    while(i<n){
        alumnos3[k] = alumnos1[i];
        i++;
        k++;
    }

    while(j<m){
        alumnos3[k] = alumnos2[j];
        j++;
        k++;
    }

    return;
}


void imprimir(int h,datos alumnos3[],FILE* f6){
    int i=0;
    for(i=0;i<h;i++){
        fwrite(&alumnos3[i],sizeof(datos),1,f6);
    }
    fseek(f6,0,SEEK_SET);

    cout<<"\nNUEVO ARCHIVO ORDENADO";
    while(fread(&alumnos3[i],sizeof(datos),1,f6)){
        cout<<"\n\nNombre: "<<alumnos3[i].apellidonombre;
        cout<<"\nNúmero de Legajo: "<<alumnos3[i].nrolegajo;
        cout<<"\nCódigo de Materia: "<<alumnos3[i].codmateria;
        i++;
    }
    cout<<"\n";

    return; 
}