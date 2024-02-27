#include <iostream>

using namespace std;

struct participantes{
    int ID_Participante,horaPartida,horaLlegada,categoria,etapa;
};



int main(){
    FILE* f = fopen("inscripciones.dat","rb");
    
    fseek(f,0,SEEK_END);
    int tam = ftell(f)/sizeof(participantes);
    fseek(f,0,SEEK_SET);

    participantes aux;
    participantes par[tam];
    int i=0,j=0,actual,contador,cont=0;

    while(fread(&aux,sizeof(participantes),1,f)){
        par[i] = aux;
        i++;
    }
    fseek(f,0,SEEK_SET);

    for(i=1;i<tam;i++){
        for(j=1;j<=tam-i;j++){
            if((par[j-1].ID_Participante) > (par[j].ID_Participante)){
                aux = par[j-1];
                par[j-1] = par[j];
                par[j] = aux;
            }
        }
    }

    for(i=0;i<tam;i++){
        cout<<"\n\nID: "<<par[i].ID_Participante;
        cout<<"\n\nHora de partida: "<<par[i].horaPartida;
        cout<<"\n\nHora de llegada: "<<par[i].horaLlegada;
        cout<<"\n\ncategoria: "<<par[i].categoria;
    }

    i=0;
    cout<<"\n\nPODIO";
    while(i<tam){
        actual = par[i].ID_Participante;
        contador=0;
        while(i<tam && actual == par[i].ID_Participante){
            contador++;
            i++;
        }
        if(contador == 3){
            cont++;
        }
    }

    participantes paro[cont];

    i=0;
    while(i<tam){
        actual = par[i].ID_Participante;
        contador=0;
        while(i<tam && actual == par[i].ID_Participante){
            contador++;
            i++;
        }
        if(contador == 3){
            paro[j] = par[i];
            j++;
        }
    }

    for(i=1;i<cont;i++){
        for(j=1;j<=cont-i;j++){
            if((paro[j-1].horaLlegada - paro[j-1].horaPartida) >)
        }
    }

    fclose(f);

    return 0;
}