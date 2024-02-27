#include <iostream>
#include <iomanip>

using namespace std;
int main(){
   int n,i,j;

   cout<<"\nIngrese cantidad de cursos: "; cin>>n;
   while(n>20){
      cout<<"\nIngrese cantidad de cursos: "; cin>>n;
   }

   struct alumno{
      float legajo;
      int nota;
   };

   struct curso{
      char codigo[4];
      int cantidad;
      alumno alumnos[100];
   };

   curso cursos[n];

   for(i=0;i<n;i++){
      fflush(stdin);
      cout<<"\nIngrese código de curso "<<i+1<<": ";
      cin.getline(cursos[i].codigo,4,'\n');
      cout<<"\nIngrese cantidad de alumnos del curso "<<cursos[i].codigo<<": ";
      cin>>cursos[i].cantidad;
      for(j=0;j<cursos[i].cantidad;j++){
         cout<<"\nIngrese legajo del alumno "<<j+1<<" del curso "<<cursos[i].codigo<<": ";
         cin>>cursos[i].alumnos[j].legajo;
         cout<<"\nIngrese la nota del alumno "<<j+1<<" del curso "<<cursos[i].codigo<<": ";
         cin>>cursos[i].alumnos[j].nota;
      }
      cout<<"\n";
   }

   for(i=0;i<n;i++){
      cout<<"\nCURSO "<<cursos[i].codigo<<": ";
      int notas[11]={0};

      for(j=0;j<cursos[i].cantidad;j++){
         notas[cursos[i].alumnos[j].nota]++;
      }

      for(j=0;j<11;j++){
         cout<<"\nCantidad de alumnos con "<<j<<": "<<notas[j];
      }
   
      float aprobados = (notas[7]+notas[8]+notas[9]+notas[10])*100/cursos[i].cantidad;
      float insuficientes = (notas[0]+notas[1]+notas[2]+notas[3]+notas[4]+notas[5]+notas[6])*100/cursos[i].cantidad;

      cout<<"\nPorcentaje de aprobados: "<<fixed<<setprecision(2)<<aprobados<<" %";
      cout<<"\nPorcentaje de insuficientes: "<<fixed<<setprecision(2)<<insuficientes<<" %\n";
      
   }
}
