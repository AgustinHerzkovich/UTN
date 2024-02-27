#include <iostream>

using namespace std;

struct nodo{
    char info;
    nodo* sgte;
};

struct regarchivo{
    char dato;
};

int const N = 100;
nodo* pila = NULL;

char vector[N]; //vector para la cola

int inicio =0,fin=0;

regarchivo aux;

FILE* f = fopen("datos.dat","rb+");

void push(nodo*& pila,char info){
   nodo* p = new nodo(); 
   p->info = info; 
   p->sgte = pila; 
   pila = p; 

   return;
}

char pop(nodo*& pila){
   char x; 
   nodo* p = pila; 
   x = pila->info; 
   pila = p->sgte; 
   delete p; 

   return x; 
}

void agregar_A_FIFO(char vector[],char c,int& indice){
    vector[indice] = c;
    indice++;

    return;
}

char suprimirDe_FIFO(char vector[], int& indice){
    char dato;
    dato = vector[indice];
    indice++;
    return dato;
}

void ingresarCaracteres(FILE* f,char vector[],nodo*& pila){
    char c;
    int i = 0;
    while(fread(&aux,sizeof(regarchivo),1,f)){
        c = fgetc(f);
        if(c!= ' '){
            push(pila,c);
            agregar_A_FIFO(vector,c,i);
        }
    }
    return;
}

bool esPalindromo(nodo*& pila,char vector[]){
    int i=0;
    while(pila!= NULL){
        if(pop(pila) != suprimirDe_FIFO(vector,i)){
            return 0;
        }
        return 1;
    }
}



