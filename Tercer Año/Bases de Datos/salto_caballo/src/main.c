#include <stdio.h>
#include <stdlib.h>
#include "salto_caballo.h"
#include "arbol.h"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("Uso: %s <x> <y>\n", argv[0]);
        return 1;
    }

    int x = atoi(argv[1]);
    int y = atoi(argv[2]);

    if (!esPosicionValida(x, y))
    {
        printf("Error: La posición inicial (%d, %d) está fuera del tablero.\n", x, y);
        return 1;
    }

    inicializarTablero();
    Nodo *raiz = crearNodo(x, y);

    if (resolverSaltoCaballo(raiz, x, y, 1))
    {
        printf("Recorrido encontrado desde (%d, %d):\n", x, y);
        imprimirRecorrido(raiz);
    }
    else
    {
        printf("No se encontró una solución desde la posición (%d, %d).\n", x, y);
    }

    liberarArbol(raiz);
    return 0;
}
