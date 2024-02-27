#include <iostream>
using namespace std;
int main(){
    int a,b,c;
    cout<<"\nIngrese los lados del triangulo: "; cin>>a>>b>>c;
    if (a>0&&b>0&&c>0){
        if(a<b+c&&b<a+c&&c<a+b){
            cout<<"\nForman triangulo";
        }
        else{
            cout<<"\nNo forman triangulo";
        }
    }
    else{
        cout<<"\nNo forman triangulo";
    }
   return 0;
}