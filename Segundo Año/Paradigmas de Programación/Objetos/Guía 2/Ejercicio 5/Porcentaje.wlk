class Porcentaje {
    var porcentaje = 1

    method valor(numero) {
        porcentaje = numero / 100
    }

    method aplicarA(numero) = numero * porcentaje
}