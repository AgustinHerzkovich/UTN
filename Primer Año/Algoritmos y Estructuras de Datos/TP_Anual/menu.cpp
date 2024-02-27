#include <iostream>
#include <cstring>

#define tamanio 10 //Tamaño del vector de medicamentos 

using namespace std;

//Estructuras de los archivos
struct pacientes{
    int idpaciente,fechanacimiento,dni,telefono;
    char apeynom[20+1];
};

struct medicos{
    int idmedico,matricula;
    char apeynom[20+1],especialidad[20+1];
};

struct atenciones{
    int idatencion,fecha,idmedico,idpaciente,idmedicamento;
    char diagnostico[50+1];
};

//Estructura del vector
struct medicamentos{
    int idmedicamento;
    char descripcion[50+1],presentacion[50+1];
};

//Estructuras de las listas
struct nodopacientes{
    pacientes info;
    nodopacientes* sgte;
};

struct nodomedicos{
    medicos info;
    nodomedicos* sgte;
};

struct nodoatenciones{
    atenciones info;
    nodoatenciones* sgte;
};

//Prototipos de funciones
void LLenarlistas(FILE*,FILE*,FILE*,nodopacientes*&,nodomedicos*&,nodoatenciones*&);
void menu (nodopacientes*&,nodomedicos*&,nodoatenciones*&,medicamentos[]);
nodopacientes* InsertarOrdenadoDNI(nodopacientes*&,pacientes);
nodomedicos* InsertarOrdenadoMedico(nodomedicos*&,medicos);
nodoatenciones* InsertarOrdenadoID(nodoatenciones*&,atenciones);
nodopacientes* buscarDNI(nodopacientes*,int);
nodomedicos* buscarMedico(nodomedicos*,char[]);
nodoatenciones* buscarAtencion(nodoatenciones*,nodopacientes*,int);
void ordenarVector(medicamentos[],int);
int busquedaBinaria(medicamentos[],int,int);

int main(){
    //Declaración de archivos como lectura
    FILE* pac = fopen("Pacientes.dat","rb");
    FILE* med = fopen("Medicos.dat","rb");
    FILE* aten = fopen("Atenciones.dat","rb");
    
    //Vector de medicamentos
    medicamentos vec[tamanio]={{4567,"Benazepril","Cada 8hs."},{2345,"Ibuprofeno","Cada 6hs."},{890,"Cefotaxima","Cada 5hs."},
    {567,"Zaleplon y Aspirina","Cada 2hs."},{5678,"Levotiroxina","Cada 4hs."},{98765,"Bretilio","Cada 3hs."},{65432,"Betametasona","Cada 8hs."},{78901,"Buscapina","Cada 5hs."},
    {12345,"Tafirol","Cada 6hs."},{23456,"Hipoglos","Cada 24hs."}};
    ordenarVector(vec,tamanio);

    //Inicialización de listas
    nodopacientes* listapacientes = NULL;
    nodomedicos* listamedicos = NULL;
    nodoatenciones* listaatenciones = NULL;
    
    LLenarlistas(pac,med,aten,listapacientes,listamedicos,listaatenciones); //Pasar los datos de archivos a listas
    
    menu(listapacientes,listamedicos,listaatenciones,vec); //Menú principal

    fclose(pac);
    fclose(med);
    fclose(aten);
    
    return 0;
}

//Función menú
void menu(nodopacientes*& listapacientes,nodomedicos*& listamedicos,nodoatenciones*& listaatenciones,medicamentos vec[]){
    int opcion,dni,dia,mes,anio;
    char apeynom[20+1];
    nodoatenciones* aux = NULL;
    do{
        cout<<"\t---------- Menu Principal ----------\n";
        cout<<"1. Informe de pacientes por DNI\n";
        cout<<"2. Informe de medicos por apellido y nombre\n";
        cout<<"3. Informe de atenciones por paciente dado el DNI\n";
        cout<<"4. Salir\n";
        cout<<"Ingrese una opcion: ";
        cin >> opcion;

        switch (opcion){
            case 1:
                cout<<"\nIngrese DNI: "; 
                cin>>dni;
                if(buscarDNI(listapacientes,dni) == NULL){
                    cout<<"\nEl paciente no se encuentra registrado.\n\n";
                    break;
                }
                cout<<"\nNombre y Apellido: "<<buscarDNI(listapacientes,dni)->info.apeynom;
                dia = (buscarDNI(listapacientes,dni)->info.fechanacimiento)%100;
                mes = ((buscarDNI(listapacientes,dni)->info.fechanacimiento)/100)%100;
                anio = (buscarDNI(listapacientes,dni)->info.fechanacimiento)/10000;
                cout<<"\nFecha de Nacimiento: "<<dia<<"/"<<mes<<"/"<<anio;
                cout<<"\nID Paciente: "<<buscarDNI(listapacientes,dni)->info.idpaciente;
                cout<<"\nTelefono: "<<buscarDNI(listapacientes,dni)->info.telefono;
                cout<<"\n\n***********************************************\n\n";
                break;

            case 2:
                cout<<"\nIngrese Nombre y Apellido del medico: ";
                cin>>apeynom;
                if(buscarMedico(listamedicos,apeynom) == NULL){
                    cout<<"\nEl medico no se encuentra registrado.\n\n";
                    break;
                }
                cout<<"\nId Medico: "<<buscarMedico(listamedicos,apeynom)->info.idmedico;
                cout<<"\nMatricula: "<<buscarMedico(listamedicos,apeynom)->info.matricula;
                cout<<"\nEspecialidad: "<<buscarMedico(listamedicos,apeynom)->info.especialidad;
                cout<<"\n\n***********************************************\n\n";
                break;

            case 3:
                cout<<"\nIngrese DNI: ";
                cin>>dni;
                if(buscarDNI(listapacientes,dni) == NULL){
                    cout<<"\nEl paciente no se encuentra registrado.\n\n";
                    break;
                }
                if(buscarAtencion(listaatenciones,listapacientes,dni) == NULL){
                    cout<<"\nEl paciente no fue atendido.\n\n";
                    break;
                }
                cout<<"\nId Paciente: "<<buscarDNI(listapacientes,dni)->info.idpaciente;
                cout<<"\nNombre y Apellido: "<<buscarDNI(listapacientes,dni)->info.apeynom;
                cout<<"\n";
                aux = listaatenciones;
                while(aux!=NULL){
                    if(aux->info.idpaciente == (buscarDNI(listapacientes,dni)->info.idpaciente)){
                        cout<<"\nId Atencion: "<<aux->info.idatencion;
                        dia = (aux->info.fecha)%100;
                        mes = ((aux->info.fecha)/100)%100;
                        anio = (aux->info.fecha)/10000;
                        cout<<"\nFecha: "<<dia<<"/"<<mes<<"/"<<anio;
                        cout<<"\nId Medico: "<<aux->info.idmedico;
                        cout<<"\nId Medicamento: "<<aux->info.idmedicamento;
                        cout<<"\nDescripcion Medicamento: "<<vec[busquedaBinaria(vec,tamanio,aux->info.idmedicamento)].descripcion;
                        cout<<"\nPrescripcion Medicamento: "<<vec[busquedaBinaria(vec,tamanio,aux->info.idmedicamento)].presentacion;
                        cout<<"\nDiagnostico: "<<aux->info.diagnostico;
                        cout<<"\n";
                    }
                    aux = aux->sgte;
                }
                cout<<"\n\n***********************************************\n\n";
                break;

            case 4:
                cout <<"\nSaliendo del programa...\n";
                break;
                
            default:
                cout <<"\nOpcion no valida. Intente nuevamente.\n\n";
                break;
        }   

    } while(opcion!=4); //Itera el menú siempre y cuando la opción seleccionada no sea 4

    return;
}

//Función para insertar en la lista ordenando por dni de manera creciente
nodopacientes* InsertarOrdenadoDNI(nodopacientes*& lista,pacientes val){
    nodopacientes* n = new nodopacientes();
    n->info = val;
    if(lista == NULL || lista->info.dni > val.dni)
    {
        n->sgte = lista;
        lista = n;
    }
    else
    {
        nodopacientes* aux = lista;
        while(aux->sgte != NULL && aux->sgte->info.dni < val.dni){
            aux = aux->sgte;
        }
        n->sgte = aux->sgte;
        aux->sgte = n;
    }
    return n;
}

//Función para insertar en la lista ordenando por nombre y apellido de manera creciente
nodomedicos* InsertarOrdenadoMedico(nodomedicos*& lista,medicos val){
    nodomedicos* n = new nodomedicos();
    n->info = val;
    if(lista == NULL || strcmp(lista->info.apeynom, val.apeynom)==1)
    {
        n->sgte = lista;
        lista = n;
    }
    else
    {
        nodomedicos* aux = lista;
        while(aux->sgte != NULL && strcmp(aux->sgte->info.apeynom , val.apeynom))
            aux = aux->sgte;
        n->sgte = aux->sgte;
        aux->sgte = n;
    }
    return n;
}

//Función para insertar en la lista ordenando por ID de manera creciente
nodoatenciones* InsertarOrdenadoID(nodoatenciones*& lista,atenciones val){
    nodoatenciones* n = new nodoatenciones();
    n->info = val;
    if(lista == NULL || lista->info.idatencion > val.idatencion)
    {
        n->sgte = lista;
        lista = n;
    }
    else
    {
        nodoatenciones* aux = lista;
        while(aux->sgte != NULL && aux->sgte->info.idatencion< val.idatencion)
        aux = aux->sgte;
        n->sgte = aux->sgte;
        aux->sgte = n;
    }
    return n;
}

//Función para llenar las distintas listas con los datos de los archivos
void LLenarlistas(FILE* pac,FILE* med, FILE* aten,nodopacientes*& listapacientes,nodomedicos*& listamedicos,nodoatenciones*& listaatenciones){
    pacientes aux_pac;
    while (fread(&aux_pac,sizeof(pacientes),1,pac)){
        InsertarOrdenadoDNI(listapacientes,aux_pac);
    }
    
    medicos aux_med;
    while (fread(&aux_med,sizeof(medicos),1,med))
    {
        InsertarOrdenadoMedico(listamedicos,aux_med);
    }

    atenciones aux_ate;
    while (fread(&aux_ate,sizeof(atenciones),1,aten))
    {
        InsertarOrdenadoID(listaatenciones,aux_ate);
    }
    return;
}

//Función para buscar en la lista de pacientes un DNI y retornar el puntero
nodopacientes* buscarDNI(nodopacientes* lista, int buscado){
    nodopacientes* aux = lista; 
    while(aux!=NULL && aux->info.dni != buscado){ 
        aux = aux->sgte; 
    }

    return aux;
}

//Función para buscar en la lista de médicos un nombre y apellido de un médico y retornar el puntero
nodomedicos* buscarMedico(nodomedicos* lista, char buscado[]){
    nodomedicos* aux = lista; 
    while(aux!=NULL && strcmp(aux->info.apeynom,buscado)!=0){
        aux = aux->sgte; 
    }
    return aux; 
}

//Función para buscar en la lista de atenciones una id de paciente, y retornar el puntero
nodoatenciones* buscarAtencion(nodoatenciones* lista,nodopacientes* listax, int buscado){
    nodoatenciones* aux = lista;
    while(aux!=NULL && aux->info.idpaciente != buscarDNI(listax,buscado)->info.idpaciente){
        aux = aux->sgte;
    }
    return aux;
}

//Función para ordenar el vector de medicamentos
void ordenarVector(medicamentos arr[],int size){
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (arr[j].idmedicamento > arr[j + 1].idmedicamento) {
                medicamentos aux= arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = aux;
            }
        }
    }
    return;
}

//Función de búsqueda binaria para buscar por id de medicamento en el vector de medicamentos
int busquedaBinaria(medicamentos arr[],int size, int objetivo){
    int izquierda = 0;
    int derecha = size - 1;
    int medio = 0;

    while (izquierda <= derecha) {
        medio = izquierda + (derecha - izquierda) / 2;
        if (arr[medio].idmedicamento == objetivo) {
            return medio; 
        } else if (arr[medio].idmedicamento < objetivo) {
            izquierda = medio + 1; 
        } else {
            derecha = medio - 1; 
        }
    }
    return -1;
}