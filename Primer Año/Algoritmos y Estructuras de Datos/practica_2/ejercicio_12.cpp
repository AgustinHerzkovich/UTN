#include <iostream>
#include <cstring>

using namespace std;

struct datos1{
    char nombre[20+1];
    int dia,mes,año;
};

struct datos2{
    int legajo;
    char apellido[20+1],nombre[20+1];
    float nota1,nota2,nota3;
};

void a_b(int,datos1[]);
void c(int,datos2[]);
void d(datos2[]);
int e(int,datos2[]);

int main(){
    const int tam = 20;
    datos1 vec1[tam];
    datos2 vec2[tam];

    a_b(tam,vec1);
    c(tam,vec2);
    d(vec2);
    int resultado = e(tam,vec2);
    if(resultado!=-1){
        cout<<"\n\nEl legajo 45678 se encuentra en la posición "<<resultado;
    }
    else{
        cout<<"\n\nEl legajo 45678 no se encuentra";
    }
    
    return 0;
}

void a_b(int tam,datos1 vec1[]){
    datos1 vec1[tam];
    cout<<"\n\nLa posición 8 del vector, campo día: "<<vec1[8].dia;
    cout<<"\nLa posición 0 del vector, campo nombre: "<<vec1[0].nombre;

    return;
}

void c(int tam,datos2 vec2[]){
    int i,pos;
    datos2 vec2[tam];
    for(i=0;i<tam;i++){
        if(vec2[i].legajo == 456789){
            pos = i;
        }
        else{
            pos = 0;
        }
    }

    if(pos!=0){
        cout<<"\n\nLa posición del LEGAJO 456789: "<<pos;
        cout<<"\nNota 1: "<<vec2[pos].nota1;
        cout<<"\nNota 2: "<<vec2[pos].nota2;
        cout<<"\nNota 3: "<<vec2[pos].nota3;
    }
    else{
        cout<<"\n\nEl legajo 45678 no se encuentra";
    }

    return;
}

void d(datos2 vec2[]){
    int i=0,pos;
    while(strcmp(vec2[i].nombre,"xxxxx")!=0){
        i++;
    }
    pos = i+1;

    cout<<"\n\nLa posición del primer apellido 'xxxxx': "<<pos;
    cout<<"\nLegajo: "<<vec2[pos].legajo;
    cout<<"\nNombre: "<<vec2[pos].nombre;
    cout<<"\nNota 1: "<<vec2[pos].nota1;
    cout<<"\nNota 2: "<<vec2[pos].nota2;
    cout<<"\nLNota 3: "<<vec2[pos].nota3;

    return;
}

int e(int tam,datos2 vec2[]){
    int izquierda = 0,derecha = tam - 1,medio;

    while(izquierda <= derecha){
        medio = izquierda + (derecha - izquierda)/2;
        if(vec2[medio].legajo == 45678){
            return medio;
        }
        else if(vec2[medio].legajo < 45678){
            izquierda = medio +1;
        }
        else{
            derecha = medio - 1;
        }
    }

    return -1;
}