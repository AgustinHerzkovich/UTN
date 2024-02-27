#include <iostream>
using namespace std;
int main(){
    int edad;
    cout<<"\nIngrese su edad: "; cin>>edad;
    if(edad<=12){
        cout<<"\nMenor";
    }
    else if(edad>=13&&edad<=18){
        cout<<"\nCadete";
    }
    else if(edad>18&&edad<=26){
        cout<<"\nJuvenil";
    }
    else{
        cout<<"\nMayor";
    }
   return 0;
}