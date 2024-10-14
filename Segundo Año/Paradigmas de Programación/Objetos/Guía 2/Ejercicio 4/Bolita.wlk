class Bolita {
    const property peso
    const property lisa
    var velocidadInicial
    var tiempoTotal = 0

    method pasar(tramo) {
        tramo.pasar(self)
    }

    method demorar(tiempo) {
        tiempoTotal += tiempo
    }

    method acelerar(velocidad) {
        velocidadInicial += velocidad
    }

    method tiempoViaje() = tiempoTotal

    method velocidadActual() = velocidadInicial
}