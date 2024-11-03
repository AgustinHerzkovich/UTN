class Ejercito {
    var puntosMoral
    const property integrantes = []

    method aumentarMoralidad(cantidad) {
        puntosMoral += cantidad
    }

    method poderAtaque() = integrantes.sum{personaje => personaje.nivelAptitud()} + puntosMoral
}