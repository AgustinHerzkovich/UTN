#include <iostream>

using namespace std;

struct nodo{
    char info;
    nodo* sgte;
};

char* dias[9];
char* colores[9];
char* caracteristicas[9];

nodo* pila = NULL;

void push(nodo*& pila,char info){
   nodo* p = new nodo(); 
   p->info = info; 
   p->sgte = pila; 
   pila = p; 

   return;
}

char pop(nodo*& pila){
   char x; 
   nodo* p = pila; 
   x = pila->info; 
   pila = p->sgte; 
   delete p; 

   return x; 
}

//funcion que recibe un numero y suma sus digitos hasta obtener un numero de una sola cifra
int sumadigitos(int numero){
    int suma=0;
    if(numero<10){
        return numero;
    }
    else{
        while(numero>0){
            suma+=numero%10;
            numero /= 10;
        }
        return sumadigitos(suma); //llama a la funcion de manera recursiva
    }
}

//funcion para pedirle al usuario que ingrese el nombre y se almacena en una pila
nodo* ingresarnombre(void){
    int l,i;
    char c;
    cout<<"\nIngrese cantidad de letras: "; cin>>l;
    for(i=0;i<l;i++){
        cout<<"\nIngrese caracter: "; cin>>c;
        push(pila,c);
    }
    return pila;
}


//funcion que devuelve el numero afortunado al recibir una estructura con un nombre
unsigned numeroafortunado(nodo*& pila){
    char letra;
    unsigned num,suma=0;
    while(pila!=NULL){
        letra = pop(pila);
        num = letra - 'A' + 1;
        suma += num;
    }
    unsigned numafortunado = sumadigitos(suma);
    return numafortunado;
}

//funcion que muestra los datos que corresponden al numero afortunado
void mostrarresultado(unsigned num){
    cout<<"\nSu día es: "<<dias[num];
    cout<<"\nSu color es: "<<colores[num];
    cout<<"\nSu característica es: "<<caracteristicas[num];
    return;
}