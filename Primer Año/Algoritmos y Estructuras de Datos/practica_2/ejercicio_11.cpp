#include <iostream>

using namespace std;

void pedirvalor(int&);
void rellenardatos(int,int[][50]);
void leerporfila(int,int[][50]);
void informarporcolumna(int,int[][50]);
void sumatoriaypromedio(int,int[][50]);
void maximo(int,int[][50]);
void minimofilaycolumna(int&,int[][50]);
void diagonal(int,int[][50]);

int main(){
   int n,mat[50][50];

   pedirvalor(n);

   rellenardatos(n,mat);
   leerporfila(n,mat);
   informarporcolumna(n,mat);
   sumatoriaypromedio(n,mat);
   maximo(n,mat);
   minimofilaycolumna(n,mat);
   diagonal(n,mat);

   return 0;
}

void pedirvalor(int& n){
    cout<<"\nIngrese un valor N (<50): "; cin>>n;
    while(n>=50){
        cout<<"\nIngrese un valor N (<50): "; cin>>n;
    }
    return;
}

void rellenardatos(int n, int mat[][50]){
    int i,j;

    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            cout<<"\nIngrese número ["<<i+1<<"] ["<<j+1<<"]: ";
            cin>>mat[i][j];
        }
    }
    return;
}

void leerporfila(int n, int mat[][50]){
    int i,j;

    cout<<"\n\nINFORME POR FILA";
    for(i=0;i<n;i++){
        cout<<"\nFila "<<i+1<<": ";
        for(j=0;j<n;j++){
            cout<<mat[i][j]<<"  ";
        }
    }
    return;
}

void informarporcolumna(int n, int mat[][50]){
    int i,j;

    cout<<"\n\nINFORME POR COLUMNA";
    for(i=0;i<n;i++){
        cout<<"\nColumna "<<i+1<<": ";
        for(j=0;j<n;j++){
            cout<<mat[j][i]<<"  ";
        }
    }
    return;
}

void sumatoriaypromedio(int n, int mat[][50]){
    int i,j,suma=0,prom=0;

    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            suma += mat[i][j];
            prom++;
        }
    }

    cout<<"\n\nSUMATORIA DE ELEMENTOS: "<<suma;
    cout<<"\nVALOR PROMEDIO: "<<suma/prom;

    return;
}

void maximo(int n, int mat[][50]){
    int i,j,mayor=-9999999,posx,posy;

    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            if(mat[i][j] > mayor){
                mayor = mat[i][j];
                posx = i;
                posy = j;
            }
        }
    }

    cout<<"\n\nMÁXIMO ELEMENTO: "<<mayor;
    cout<<"\nUBICACIÓN: ["<<posx+1<<"]["<<posy+1<<"]"; 

    return;
}

void minimofilaycolumna(int& n,int mat[][50]){
    int i,j,menor;

    cout<<"\n\nMÍNIMOS POR FILA";
    for(i=0;i<n;i++){
        menor = mat[i][0];
        for(j=0;j<n;j++){
            if(mat[i][j] < menor){
                menor = mat[i][j];
            }
        }
        cout<<"\nMínimo de fila "<<i+1<<": "<<menor;
    }

    cout<<"\n\nMÍNIMOS POR COLUMNA";
    for(i=0;i<n;i++){
        menor = mat[i][0];
        for(j=0;j<n;j++){

            if(mat[j][i] < menor){
                menor = mat[j][i];
            }
        }
        cout<<"\nMínimo de columna "<<i+1<<": "<<menor;
    }

    return;
}

void diagonal(int n, int mat[][50]){
    int i,j,posi=0,neg=0;

    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            if(i==j && mat[i][j]>0){
                posi++;
            }
            if(j==i && mat[j][i]<0){
                neg++;
            }
        }
    }

    cout<<"\n\nPOSITIVOS EN LA DIAGONAL PRINCIPAL: "<<posi;
    cout<<"\nNEGATIVOS EN LA DIAGONAL SECUNDARIA: "<<neg;
    return;
}





/*11.	Dado un valor N (<50), y una matriz MAT[NxN] que contiene valores enteros.
Se pide:
a) Leerla por fila
b) Informarla por columna
c) Informar la sumatoria de sus elementos y el valor promedio
d) Informar el máximo elemento y su ubicación (fila y columna)
e) Informar el mínimo de cada fila y el máximo de cada columna
f) Informar cuantos elementos positivos hay en la diagonal principal y cuantos negativos en la diagonal secundaria
*/