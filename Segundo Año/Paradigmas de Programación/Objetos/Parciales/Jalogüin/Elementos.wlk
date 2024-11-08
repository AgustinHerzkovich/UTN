object maquillaje {
    var susto = 3

    method susto() = susto

    method modificarSusto(nuevoSusto) {
        susto = nuevoSusto
    }
}

class Traje {
    const personaje

    method susto() = personaje.cuantoAsusta()
}

// Personajes
object tierno {
    method cuantoAsusta() = 2
}

object terrorifico {
    method cuantoAsusta() = 5
}