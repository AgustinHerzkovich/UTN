class Ciudad {
    var cantidadHabitantes

    method puedeSerSaqueadoPor(unPirata) = unPirata.tieneNivelDeEbriedadMinimo(50)

    method esVulnerableA(unBarco) = unBarco.cantidadTripulantesMayorOIgualA(cantidadHabitantes * 0.4) || unBarco.estanTodosPasadosDeGrogXD()

    method agregarHabitante(unaPersona) {
        cantidadHabitantes += 1
    }
}