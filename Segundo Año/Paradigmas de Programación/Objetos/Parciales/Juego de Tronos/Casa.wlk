class Casa {
    var patrimonio = 0
    const ciudad = null
    const property miembros = []

    method esRica() = patrimonio > 1000

    method patrimonioIndividual() = patrimonio / self.cantidadMiembros()

    method cantidadMiembros() = miembros.size()

    method algunIntegranteVivoYSoltero() = miembros.find{integrante => integrante.estavivo() and integrante.estaSoltero()}

    method perderDinero(unPorcentaje) {
        patrimonio *= 1 - unPorcentaje / 100
    }
}

object lannister inherits Casa(ciudad = "Roca Casterly") {
    method admiteCasamiento(unPersonaje, otroPersonaje) = unPersonaje.estaSoltero() and otroPersonaje.estaSoltero()
}

object stark inherits Casa(ciudad = "Invernalia") {
    method admiteCasamiento(unPersonaje, otroPersonaje) = unPersonaje.esDeDistintaCasa(otroPersonaje)
}

object guardiaDeLaNoche inherits Casa(ciudad = "Ankh-Morpork") {
    method admiteCasamiento(unPersonaje, otroPersonaje) = false
}

object casaMasPobre inherits Casa(){} // Doy por hecho que ya existe