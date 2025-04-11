#ifndef SALTO_CABALLO_H
#define SALTO_CABALLO_H

#include "arbol.h"

#define DIMENSION 8
#define MOVIMIENTOS_POSIBLES 8

extern int tablero[DIMENSION][DIMENSION];

int esPosicionValida(int x, int y);
void inicializarTablero();
int resolverSaltoCaballo(Nodo *actual, int x, int y, int movimientosRealizados);

#endif
