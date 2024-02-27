#include <iostream>
using namespace std;
void funcion(int, int[]); 
int main(){
    int n;
    cout<<"\nIngrese un numero menor que 30: ";
    cin>>n;
    while(n>30 && n<0){
    cout<<"\nIngrese un numero menor que 30: ";
    cin>>n;
    }
    int vec[n];
    funcion(n,vec); 
    return 0;
}
void funcion(int n, int vec[]){ 
    int elem; 
    for (int i=0;i<n;i++){ 
        cout<<"\nIngrese elemento: "; cin>>elem;
        vec[i]=elem;
    }
    if (vec[n-1]<10){
    for (int i=0;i<n;i++){ 
        if(vec[i]<0){
            cout<<vec[i]<<endl;
        }
    }
    }
    else {
        for (int i=0;i<n;i++){
            if(vec[i]>0){
            cout<<vec[i]<<endl;
        }
        }
    }
    return;
}
