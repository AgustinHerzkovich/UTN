CC=gcc
CFLAGS=-Wall -g
OBJ=main.o salto_caballo.o arbol.o

salto_caballo: $(OBJ)
	$(CC) $(CFLAGS) -o salto_caballo $(OBJ)

main.o: main.c salto_caballo.h arbol.h
	$(CC) $(CFLAGS) -c main.c

salto_caballo.o: salto_caballo.c salto_caballo.h arbol.h
	$(CC) $(CFLAGS) -c salto_caballo.c

arbol.o: arbol.c arbol.h
	$(CC) $(CFLAGS) -c arbol.c

clean:
	rm -f *.o salto_caballo
