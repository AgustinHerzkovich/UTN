object flautistaDeHamelin {
    const ratones = []
    
    method tocarLaFlauta() = self.ratonesAmbiciosos().forEach{raton => raton.dilapidarCapital()}

    method ratonesAmbiciosos() = ratones.filter{raton => raton.esAmbicioso()}

    method duplicarSueldoPersonajePeorPago() {
        self.personajePeorPagoDeCadaRaton().forEach{personaje => personaje.duplicarSueldo()}
    }

    method personajePeorPagoDeCadaRaton() = ratones.map{raton => raton.personajePeorPago()}
}