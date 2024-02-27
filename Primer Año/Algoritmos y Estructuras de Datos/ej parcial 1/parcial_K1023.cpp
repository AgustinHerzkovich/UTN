#include <iostream>

using namespace std;

struct pacientes{
    int id;
    char nombre[50+1],apellido[50+1];
};

struct medicamentos{
    int idMedicamento,EAN,dosis;
    char nombreG[50+1];
};

struct prescripciones{
    int idPaciente,idMedicamento;
    float intervalo,hora;
};

struct horas{
    int idPaciente,num,dia;
    float hora;
};

int* presc();

int main(){
    FILE* f = fopen("medicamentos.dat","rb");

    fseek(f,0,SEEK_END);
    int tam = ftell(f)/sizeof(medicamentos);
    fseek(f,0,SEEK_SET);

    medicamentos med[tam];
    medicamentos aux;

    int i=0;

    while(fread(&aux,sizeof(medicamentos),1,f)){
        med[i] = aux;
        i++;
    }

    int n,cant,m;
    cout<<"\nCantidad de pacientes: "; cin>>cant;

    int inf=0,sup=cant,mitad,cont=0;
    char band = 'F';
    pacientes vec[cant];

    cout<<"\nCantidad de prescripciones por paciente: "; cin>>m;

    prescripciones pre[cant*m];

    cout<<"\nSolicite una id de paciente: "; cin>>n;

    while(inf<=sup){
        mitad = (inf+sup)/2;

        if(vec[mitad].id == n){
            band = 'V';
        }
        else if(vec[mitad].id < n){
            inf = mitad;
            mitad =(inf+sup)/2;
        }
        else if(vec[mitad].id > n){
            sup = mitad;
            mitad = (inf+sup)/2;
        }
    }

    for(i=0;i<(cant*m);i++){
        if(pre[i].idPaciente == n){
            cont++;
        }
    }

    if(band == 'V'){

    }
    else{
        cout<<"\nEl paciente solicitado no existe";
    }




    return 0;
}

int* presc(){

}