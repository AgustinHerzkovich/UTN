#include <iostream>
using namespace std;
void Data_Setter(int&, int&, int&, int&); //funcion para pedir al usuario los datos y guardarlos
void Data_Analyzer(int, int, int, int, int&, int&); //funcion para calcular el exceso y el monto a abonar
void Data_Output(int, int); //funcion que muestra en pantalla minutos excedidos y monto a abonar

int main(){
    int costo, minLibres, cargo, minCantidad, exceso, abonar; //declaracion de variables
    costo = minLibres = cargo = minCantidad = exceso = abonar = 0; //inicializacion 
    Data_Setter(costo, minLibres, cargo, minCantidad); //invocacion 1
    Data_Analyzer(costo, minLibres, cargo, minCantidad, exceso, abonar); //invocacion 2
    Data_Output(exceso, abonar); //invocacion 3
    return 0;
}

void Data_Setter(int& costo, int& minLibres, int& cargo, int& minCantidad){
    cout<<"\nIngrese costo en pesos del abono: $"; cin >> costo;
    cout<<"\nIngrese cantidad de minutos libre: "; cin >> minLibres;
    cout<<"\nIngrese cargo en pesos por minuto excedente: $"; cin >> cargo;
    cout<<"\nIngrese cantidad de minutos utilizados por un abonado: "; cin >> minCantidad;
    return;
}

void Data_Analyzer(int costo, int minLibres, int cargo, int minCantidad, int& exceso, int& abonar){
    exceso = minLibres - minCantidad;
    if(exceso < 0){
        exceso *= -1;
    }
    abonar = (costo + cargo * exceso) * 1.21;
    return;
}

void Data_Output(int exceso, int abonar){
    cout << "\nLa cantidad de minutos excedidos es: " << exceso;
    cout << "\nEl monto a abonar es: $" << abonar;
    return;
}