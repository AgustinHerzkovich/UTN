#include <iostream>

using namespace std;
void matriz();

int main(){
   matriz();

   return 0;
}

void matriz(){
    int i,j;
    int MUL[10][10];

    for(i=0;i<10;i++){
        for(j=0;j<10;j++){
            MUL[i][j] = (i+1)*(j+1);
        }
    }

    for(i=0;i<10;i++){
        for(j=0;j<10;j++){
            cout<<MUL[i][j]<<"  ";
        }
        cout<<endl;
    }
    return;
}
