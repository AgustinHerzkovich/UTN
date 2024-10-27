class Mision {
    method puedeSerRealizadaPor(unBarco) = unBarco.tieneSuficienteTripulacion()

}
class BusquedaDelTesoro inherits Mision {
    method esUtil(unPirata) = unPirata.tieneAlgunoDeEstosItems(["brujula", "mapa", "botella de grogXD"]) && unPirata.tieneMenosDeNMonedas(5)

    override method puedeSerRealizadaPor(unBarco) = super(unBarco) && unBarco.algunoTieneItem("llave de cofre")
}

class ConvertirseEnLeyenda inherits Mision {
    const itemObligatorio

    method esUtil(unPirata) = unPirata.tieneAlMenos10Items() && unPirata.tieneItem(itemObligatorio)
}

class Saqueo inherits Mision {
    var cantidadMaximaMonedas
    const victima

    method esUtil(unPirata) = unPirata.tieneMenosDeNMonedas(cantidadMaximaMonedas) && unPirata.seAnimaASaquear(victima)

    method cambiarCantidadMaximaDeMonedas(nuevaCantidad) {
        cantidadMaximaMonedas = nuevaCantidad
    }

    override method puedeSerRealizadaPor(unBarco) = super(unBarco) && victima.esVulnerableA(unBarco)  
}