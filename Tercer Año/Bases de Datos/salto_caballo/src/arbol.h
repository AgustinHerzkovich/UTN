#ifndef ARBOL_H
#define ARBOL_H

typedef struct Nodo
{
    int x;
    int y;
    struct Nodo **hijos;
    int cantidadHijos;
} Nodo;

Nodo *crearNodo(int x, int y);
void agregarHijo(Nodo *padre, Nodo *hijo);
void liberarArbol(Nodo *raiz);
void imprimirRecorrido(Nodo *raiz);

#endif
