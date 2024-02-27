#include <iostream>
using namespace std;
int main(){
    int i,v,suma=0,cant=0;
    char m[100],g,t;
    cout<<"Bienvenido, ingrese las infracciones";
    for(i=0;i<20;i++){
        cout<<"\nTipo de infraccion: "; cin>>t;
        cout<<"\nMotivo de la infraccion: "; cin>>m;
        cout<<"\nValor de la multa: "; cin>>v;
        cout<<"\nGravedad de la infraccion('L''M,','G'): "; cin>>g;
        if (g=='L'){
            suma+=v;
        }
        else if (g=='M'){
            suma+=v*2;
        }
        else {
            suma+=v*4;
        }
        if (t=='3'||t=='4'&&g=='G'){
            cant++;
        }
    }
    cout<<"\nEl valor de multa a pagar es: "<<suma;
    if (cant>3){
        cout<<"\nClausurar fabrica";
    }
    return 0;
}