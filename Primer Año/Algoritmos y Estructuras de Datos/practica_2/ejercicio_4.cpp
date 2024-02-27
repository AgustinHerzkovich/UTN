#include <iostream>

using namespace std;

void pedir_dato(int&);
void vectorAyB(int,int,float[],int&,float[],int&);
void vectorC(int,int,float[],float[],float[],int,int);
void vectorD(int,int,float[],float[],float[]);

int main(){
    int n,i=0,par=0,impar=0;

    pedir_dato(n);

    float a[n],b[n],d[n];

    vectorAyB(i,n,a,impar,b,par);

    float c[par+impar];

    vectorC(i,n,a,b,c,par,impar);

    vectorD(i,n,a,b,d);

   return 0;
}

//funcion donde pido al usuario la cantidad de posiciones de los vectores A y B
void pedir_dato(int& n){
    cout<<"\nIngrese cantidad de posiciones (menor a 25): ";
    cin>>n;

    while (n>25){
        cout<<"\nIngrese cantidad de posiciones (menor a 25): ";
        cin>>n;
    }

    return;
}

//funcion donde el usuario rellena los vectores A y B
void vectorAyB(int i, int n, float a[], int& impar, float b[], int& par){
    cout<<"\n--VECTOR A--";
    for(i=0;i<n;i++){
        cout<<"\nIngrese dato: ";
        cin>>a[i];
        if(i%2!=0){
            impar++;
        }
    }

    cout<<"\n--VECTOR B--";
    for(i=0;i<n;i++){
        cout<<"\nIngrese dato: ";
        cin>>b[i];
        if(i%2==0){
            par++;
        }
    }

    return;
}

//funcion donde se autorellena el vector C y se imprime en pantalla
void vectorC(int i,int n,float a[],float b[],float c[],int par,int impar){
     for(i=0;i<n;i++){
        if(i%2!=0){
            c[i-1]=a[i];
        }
        else{
            c[i+1]=b[i];
        }
    }

    cout<<"\n--VECTOR C--\n";
    for(i=0;i<(par+impar);i++){
        cout<<c[i]<<" ";
    }
    
    return;
}

//funcion donde se autorellena el vector D y se imprime en pantalla
void vectorD(int i,int n,float a[],float b[],float d[]){
     for(i=0;i<n;i++){
        if(a[i]==b[i]){
            d[i]=0;
        }
        else{
            d[i]=1;
        }
    }

    cout<<"\n--VECTOR D--\n";
    for(i=0;i<n;i++){
        cout<<d[i]<<" ";
    }

    return;
}