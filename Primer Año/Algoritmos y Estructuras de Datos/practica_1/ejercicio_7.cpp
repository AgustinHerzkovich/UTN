#include <iostream>
using namespace std;
int main(){
    char n1[51],n2[51],n3[51];
    float t1,t2,t3,v1,v2,v3,m1,m2,m3;
    cout<<"\nLuego de ingresar un dato, pulse enter para ingresar el siguiente";
    cout<<"\nIngrese el primer participante, con su tiempo en minutos y segundos: ";
    cin>>n1>>t1>>m1;
    cout<<"\nIngrese el segundo participante, con su tiempo en minutos y segundos: ";
    cin>>n2>>t2>>m2;
    cout<<"\nIngrese el tercer participante, con su tiempo en minutos y segundos: ";
    cin>>n3>>t3>>m3;
    t1+=m1*60;
    t2+=m2*60;
    t3+=m3*60;
    v1=1500/t1;
    v2=1500/t2;
    v3=1500/t3;
    if(v1>v2&&v1>v3){
        cout<<"\n"<<n1<<" es el mas veloz";
    }
    else if(v2>v1&&v2>v3){
        cout<<"\n"<<n2<<" es el mas veloz";
    }
    if(v1>v2&&v1>v3){
        cout<<"\n"<<n1<<" es el mas veloz";
    }
    else{
        cout<<"\n"<<n3<<" es el mas veloz";
    }
   return 0;
}