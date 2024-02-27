#include <iostream>

using namespace std;

struct datosVendedores{ //sin orden
    int idvendedor;
    char apeynom[20+1];
};

struct datosModelos{ //sin orden
    char idmodelo[4+1];
    char descripcion[20+1];
};

struct datosVentas{ //ordenado por fecha
    int idvendedor;
    char idmodelo[4+1];
    int fecha;
    char cliente[20+1];
};



int busquedaBinaria(int arr[], int size, int objetivo) {
    int izquierda = 0;
    int derecha = size - 1;

    while (izquierda <= derecha) {
        int medio = izquierda + (derecha - izquierda) / 2;

        if (arr[medio] == objetivo) {
            return medio; // El elemento se encuentra en la posición 'medio'
        } else if (arr[medio] < objetivo) {
            izquierda = medio + 1; // Buscar en la mitad derecha de la lista
        } else {
            derecha = medio - 1; // Buscar en la mitad izquierda de la lista
        }
    }

    return -1; // El elemento no se encuentra en la lista
}

void emitirListado(datosVentas ven[], int size){
    int actual,cantidad=0,i=0,;
    while(i<size){
        cantidad = 0;
        actual = ven[i].fecha;
        cout<<"\nFecha: "<<actual;
        while(i<size && actual == ven[i].fecha){
            cantidad++;
            i++;
        }
        if(cantidad>0){
            cout<<"\nCantidad de ventas del día: "<<cantidad;
        }
    }
}
    