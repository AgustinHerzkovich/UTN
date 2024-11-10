class Consumo {
    const property fecha = new Date()

    method ocurrioEnRango(fechaInicial, fechaFinal) = fecha.between(fechaInicial, fechaFinal)
}

class ConsumoInternet inherits Consumo {
    const property consumoMB

    method costo() = pdepfoni.precioPorMB() * consumoMB

    method cubiertoPorInternet(unPack) = unPack.puedeGastarMB(consumoMB)

    method cantidad() = consumoMB
}

class ConsumoLlamadas inherits Consumo {
    const property duracion

    method consumoMB() = 0

    method costo() = pdepfoni.precioFijo() + 0.max(duracion - 30) * pdepfoni.precioPorSegundo()

    method cubiertoPorLlamada(unPack) = unPack.puedeGastarMinutos(duracion)

    method cantidad() = duracion
}

object pdepfoni {
    var property precioPorMB = 0.1
	var property precioPorSegundo = 1.5
	var property precioFijo = 5
}