#include <iostream>

using namespace std;

void ingresarDatos(int,int,int[]);
void burbujaAscendente(int,int,int,int,int[]);
void burbujaDescendente(int,int,int,int,int[]);

int main(){
   int N=0,i=0,j=0,aux;

   cout<<"\nIngrese cantidad de posiciones del vector: ";
   cin>>N;
   int VEC[N];

   ingresarDatos(i,N,VEC);
   burbujaAscendente(i,j,N,aux,VEC);
   burbujaDescendente(i,j,N,aux,VEC);

   return 0;
}


void ingresarDatos(int i, int N, int VEC[]){
   for(i=0;i<N;i++){
      cout<<"\nIngrese dato: ";
      cin>>VEC[i];
   }

   return;
}

void burbujaAscendente(int i, int j, int N, int aux, int VEC[]){
   for(i=0;i<N-1;i++){
      for(j=0;j<N-i-1;j++){
         if(VEC[j]>VEC[j+1]){
            aux = VEC[j];
            VEC[j] = VEC[j+1];
            VEC[j+1] = aux; 
         }
      }
   }

   cout<<"\nOrden Ascendente:\n";
   for(i=0;i<N;i++){
      cout<<VEC[i]<<" ";
   }
   cout<<"\n";

   return;
}

void burbujaDescendente(int i, int j, int N, int aux, int VEC[]){
   for(i=0;i<N-1;i++){
      for(j=0;j<N-i-1;j++){
         if(VEC[j]<VEC[j+1]){
            aux = VEC[j];
            VEC[j] = VEC[j+1];
            VEC[j+1] = aux; 
         }
      }
   }

   cout<<"\nOrden Descendente:\n";
   for(i=0;i<N;i++){
      cout<<VEC[i]<<" ";
   }
   cout<<"\n";

   return;
}