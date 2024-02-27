#include <iostream>
using namespace std;
int main(){
    int suma=0,i;
    for(i=4;i<10000;i+=2){
        suma+=i;
    }
    cout<<"\nLa suma es: "<<suma;
   return 0;
}