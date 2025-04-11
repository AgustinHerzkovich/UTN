#include <stdio.h>
#include "salto_caballo.h"

int tablero[DIMENSION][DIMENSION];

int dx[MOVIMIENTOS_POSIBLES] = {2, 1, -1, -2, -2, -1, 1, 2};
int dy[MOVIMIENTOS_POSIBLES] = {1, 2, 2, 1, -1, -2, -2, -1};

int esPosicionValida(int x, int y)
{
    return x >= 0 && x < DIMENSION && y >= 0 && y < DIMENSION && tablero[x][y] == 0;
}

void inicializarTablero()
{
    for (int i = 0; i < DIMENSION; i++)
        for (int j = 0; j < DIMENSION; j++)
            tablero[i][j] = 0;
}

int resolverSaltoCaballo(Nodo *actual, int x, int y, int movimientosRealizados)
{
    tablero[x][y] = 1;

    if (movimientosRealizados == DIMENSION * DIMENSION)
        return 1;

    for (int i = 0; i < MOVIMIENTOS_POSIBLES; i++)
    {
        int nx = x + dx[i];
        int ny = y + dy[i];

        if (esPosicionValida(nx, ny))
        {
            Nodo *nuevo = crearNodo(nx, ny);
            agregarHijo(actual, nuevo);

            if (resolverSaltoCaballo(nuevo, nx, ny, movimientosRealizados + 1))
                return 1;
            else
                tablero[nx][ny] = 0; // backtracking
        }
    }

    return 0;
}
