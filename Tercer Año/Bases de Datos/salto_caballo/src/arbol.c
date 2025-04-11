#include <stdio.h>
#include <stdlib.h>
#include "arbol.h"

Nodo *crearNodo(int x, int y)
{
    Nodo *nuevo = (Nodo *)malloc(sizeof(Nodo));
    nuevo->x = x;
    nuevo->y = y;
    nuevo->hijos = NULL;
    nuevo->cantidadHijos = 0;
    return nuevo;
}

void agregarHijo(Nodo *padre, Nodo *hijo)
{
    padre->hijos = realloc(padre->hijos, (padre->cantidadHijos + 1) * sizeof(Nodo *));
    padre->hijos[padre->cantidadHijos++] = hijo;
}

void liberarArbol(Nodo *raiz)
{
    for (int i = 0; i < raiz->cantidadHijos; i++)
    {
        liberarArbol(raiz->hijos[i]);
    }
    free(raiz->hijos);
    free(raiz);
}

void imprimirRecorrido(Nodo *raiz)
{
    printf("(%d, %d) -> ", raiz->x, raiz->y);
    if (raiz->cantidadHijos == 0)
    {
        printf("FIN\n");
        return;
    }
    imprimirRecorrido(raiz->hijos[0]); // mostrar solo una solución
}
