#include <iostream>

using namespace std;

//1.a)

struct infoCola{
    char campo1[30+1];
    int campo2;
};

struct nodoCola{
    infoCola info;
    nodoCola* sgte;
};

//declaracion  e inicializacion
nodoCola* frente = NULL; 
nodoCola* fin = NULL;

//1.b)

struct nodoPila{
    char info[30+1];
    nodoPila* sgte;
};

//declaracion e inicializacion
nodoPila* pila = NULL;

//2.a)
/*
lo que hace la funcion es
recibe una lista, una pila y una cola
vacia la pila, y a medida que la va vaciando, va buscando en la lista
los datos de la pila, y va eliminandolos de la lista, a su vez que lo cuenta
entonces en la cola se almacena la palabra almacenada en la pila,
y la cantidad de veces que la misma aparece en la lista

si se la ejecuta con dichos datos, la cola va a quedar de la siguiente manera
palabra: algoritmos
cantidad de veces que aparece en la lista: 2
palabra: jueves
cantidad de veces que aparece en la lista: 2
palabra: parcial
cantidad de veces que aparece en la lista: 0
*/

//2.b)
else if(cant == 0){
    cout<<palabra1;
}

