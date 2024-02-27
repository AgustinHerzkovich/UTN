#include <iostream>
#include <stdlib.h>

using namespace std;

struct nodo{
    int info;
    nodo* sgte;
};

void queue(nodo*&,nodo*&,int); //funcion encolar
int unqueue(nodo*&,nodo*&); //funcion desencolar
int contador(nodo*&,nodo*&);
void llenar_vector(nodo*&,nodo*&,int[]);
void burbuja(int[],int);
void apareo(int,int,int[],int[],int[]);
void mostrar_cola(int,int[]);

int main(){
   
    nodo* frenteA = NULL; //inicializar el nodo frente
    nodo* finA = NULL; //inicializar el nodo fin 
    nodo* frenteB = NULL; //inicializar el nodo frente
    nodo* finB = NULL; //inicializar el nodo fin 

    queue(frenteA,finA,3);
    queue(frenteA,finA,8);
    queue(frenteA,finA,1);
    queue(frenteB,finB,9);
    queue(frenteB,finB,2);
    queue(frenteB,finB,4);

    int tamañoA = contador(frenteA,finA);
    int tamañoB = contador(frenteB,finB);

    int datosA[tamañoA];
    int datosB[tamañoB];
    int tamañoAB = tamañoA+tamañoB;
    int datosAB[tamañoAB];

    llenar_vector(frenteA,finA,datosA);
    llenar_vector(frenteB,finB,datosB);

    burbuja(datosA,tamañoA);
    burbuja(datosB,tamañoB);

    apareo(tamañoA,tamañoB,datosA,datosB,datosAB);
    mostrar_cola(tamañoAB,datosAB);

    return 0;
}

void queue(nodo*& frente,nodo*& fin,int info){
    nodo* p = new nodo(); //crear espacio en memoria para almacenar un nodo
    p->info = info; //insertar la info en el nodo
    p->sgte = NULL; //apunta a null
    if(frente==NULL){ //si la cola esta vacia
        frente = p; //frente apunta al nuevo nodo
    }
    else{ //si no
        fin->sgte = p; //el fin apunta al ultimo nodo siempre
    }
    fin = p; //fin apunta al nuevo nodo

    return;
}

int unqueue(nodo*& frente,nodo*& fin){
    int x; //variable para almacenar el dato
    nodo* p = frente; //nodo auxiliar asignado al frente de la cola
    x = p->info; //obtener el valor del nodo
    frente = p->sgte;
    if(frente==NULL){ //si frente apunta a null
        fin = NULL; //fin apunta a null
    }
    delete p; //eliminar nodo auxiliar

    return x; //retonar el dato
}

int contador(nodo*& frente,nodo*& fin){
    int contador=0,dato;
    nodo* frenteaux = NULL;
    nodo* finaux = NULL;
    while(frente!=NULL){
        dato = unqueue(frente,fin);
        contador++;
        queue(frenteaux,finaux,dato);
    }

    while(frenteaux!=NULL){
        dato = unqueue(frenteaux,finaux);
        queue(frente,fin,dato);
    }

    return contador;
}

void llenar_vector(nodo*& frente,nodo*& fin,int vector[]){
    int i=0;
    while(frente!=NULL){
        vector[i] = unqueue(frente,fin);
        i++;
    }

    return;
}

void burbuja(int vector[],int tam){
    int i,j,aux;
    for(i=1;i<tam;i++){
        for(j=1;j<=tam-i;j++){
            if(vector[j-1]>vector[j]){
                aux = vector[j-1];
                vector[j-1] = vector[j];
                vector[j] = aux;
            }
        }
    }

    return;
}

void apareo(int tamañoA,int tamañoB,int datosA[],int datosB[],int datosAB[]){
    int i=0,j=0,k=0;

    while(i<tamañoA && j<tamañoB){
        if(datosA[i]<datosB[j]){
            datosAB[k] = datosA[i];
            i++;
            k++;
        }
        else{
            datosAB[k] = datosB[j];
            j++;
            k++;
        }
    }

    while(i<tamañoA){
        datosAB[k] = datosA[i];
        i++;
        k++;
    }

    while(j<tamañoB){
        datosAB[k] = datosB[j];
        j++;
        k++;
    }

    return;
}

void mostrar_cola(int tamañoAB,int datosAB[]){
    int i;
    nodo* frenteAB = NULL;
    nodo* finAB = NULL;

    for(i=0;i<tamañoAB;i++){
        queue(frenteAB,finAB,datosAB[i]);
    }

    cout<<"\n\nCola apareada:\n";
    while(frenteAB!=NULL){
        cout<<unqueue(frenteAB,finAB)<<"  ";
    }

    return;
}

/*
Dadas dos colas COLA y COLB (nodo = registro + puntero), 
desarrollar y codificar un procedimiento que genere otra cola 
COLAB por apareo del campo ARRIBO del registro 
(define orden creciente en ambas).
Nota: COLA y COLB dejan de ser útiles después del apareo.
*/