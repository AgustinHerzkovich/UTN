#include <iostream>

using namespace std;

struct Electrodomestico{
	char codigoElectrodomestico[6 + 1];
	char nombreElectrodomestico[250 + 1];
	float precioUnitario;
};

struct Venta{
	char codigoElectrodomestico[6 + 1];
	int diaDelMes; // valores entre 1 y 31
	int cantidadVendida;
	int dniCliente;
	char nombreCliente[100 + 1];
};

struct infoCliente{
    int dni;
    char nombre[20+1];
};

struct nodo{
    infoCliente info;
    nodo* sgte;
};


int main(){
    Electrodomestico array[2500];
    FILE* f = fopen("ventas.dat","rb");

    int matriz[31][2500];

    return 0;
}

//armar matriz con los dias del mes en las filas, y los electrodomesticos en las columnas 
//cada celda de la matriz contiene: cantidad vendida del electrodomestico en ese dia y lista de los clientes que lo compraron ese dia


