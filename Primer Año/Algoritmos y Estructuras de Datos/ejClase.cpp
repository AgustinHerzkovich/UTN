 #include <iostream>
 using namespace std;

 struct NODO{
    info info;
    NODO* sgte;
 };

 struct info{
    int Id_empleado;
    int Id_sucursal;
 };

 struct Archivo{
    int mes;
    int Id_empleado;
    int Id_sucursal;
    int cantidad;  
 };

 struct Empleado{
    int Id_empleado;
    char nombre[30];
 };

 struct Sucursal{
    int Id_sucursal;
    char nombre[30];
 };

 struct Vector{
    int acumulador;
    NODO* pila = NULL;
 };


 void push(NODO*&, info);
 info pop(NODO*&);

 int main(){

    Archivo arch;
    info aux;
    FILE* f = fopen("VENTAS.DAT", "rb");
    int i = 0;
    int position; 
    Vector vecMeses[12];
    Empleado vecEmpleados[50];
    Sucursal vecSucursal[20];

    


    while(fread(&arch,sizeof(Archivo), 1, f)){
       position = arch.mes-1;
       vecMeses[position].acumulador+=arch.cantidad;
       aux.Id_empleado=arch.Id_empleado;
       aux.Id_sucursal=arch.Id_sucursal;
       push(vecMeses[position].pila,aux);
    }

    for(i = 0; i < 12; i++){
        cout << "\nMes: " <<i+1;
        cout<<"\nTotal vendidos"<<vecMeses[i].acumulador;
        while(vecMeses[i].pila!=NULL){
            aux = pop(vecMeses[i].pila);
            cout<<"\nVendedor: "<<vecEmpleados[aux.Id_empleado].nombre;
            cout<<"\nSucursal: "<<vecSucursal[aux.Id_sucursal].nombre;
        }
    }

    return 0;
 }

 void push(NODO* & pila, info informacion){
    NODO* p = new NODO();
    p->info = informacion;
    p->sgte = pila;
    pila = p;
    return;
 }

 info pop(NODO* & pila){
    info x;
    NODO* p = pila;
    x = pila -> info;
    pila = p ->sgte;
    delete p;
    return x;
 }