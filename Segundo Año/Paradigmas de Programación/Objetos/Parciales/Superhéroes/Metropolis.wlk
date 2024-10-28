class Metropolis {
    const poblacion = []
    const salonDeLaJusticia
    const ataquesAnteriores = []

    method danioRecibible() = poblacion.sum{ciudadano => ciudadano.danioRecibible()}

    method peorEnemigo() = poblacion.find{villano => villano.ciudadConMasExitos(self)}

    method pedirAuxilio() = salonDeLaJusticia.llamarHeroe()

    method tieneAntecedentes(unVillano) = ataquesAnteriores.contains(unVillano)

    method villanoPredilecto() = poblacion.find{villano => villano.esObjetivoPredilecto(self)}

    method serAtacadaPor(unVillano) {
        ataquesAnteriores.add(unVillano)
    }
}