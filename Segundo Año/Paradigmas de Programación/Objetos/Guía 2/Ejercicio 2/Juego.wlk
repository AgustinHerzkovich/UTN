class Juego {
    var plataActual
    var cantidadVictorias = 0
    var cantidadDerrotas = 0
    const historialApuestas = #{}

    method apostar(plata, numero) {
        if (numero.between(1, 3)) {
            const numeroGanador = 1.randomUpTo(3).truncate(0)
            historialApuestas.add(plata)
            if (numero == numeroGanador) {
                plataActual -= plata * 2
                cantidadDerrotas += 1
            } else {
                plataActual += plata
                cantidadVictorias += 1
            }
        }
    }

    method plataActual() = plataActual

    method victorias() = cantidadVictorias

    method derrotas() = cantidadDerrotas

    method apuestaMasAlta() = historialApuestas.max()
}