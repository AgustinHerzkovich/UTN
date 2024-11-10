class Arma {
    var danio = 0

    method danio() = danio

    method incrementarDanio(unaCantidad) {
        danio += unaCantidad
    }

    method reiniciarPractica() {
        danio = 0
    }
}