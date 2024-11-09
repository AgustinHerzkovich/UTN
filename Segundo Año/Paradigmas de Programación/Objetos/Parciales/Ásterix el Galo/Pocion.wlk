class Pocion {
    const ingredientes = []

    method agregarIngrediente(unIngrediente) {
        ingredientes.add(unIngrediente)
    }

    method aplicarEfecto(unaPersona) {
        ingredientes.forEach{ingrediente => ingrediente.afectar(unaPersona, self)}
    }

    method cantidadIngredientes() = ingredientes.size()
}

// Ingredientes
object dulceDeLeche {
    method afectar(unaPersona, _unaPocion) {
        unaPersona.aumentarFuerza(10)
        if (unaPersona.estaFueraDeCombate()) {
            unaPersona.aumentarResistencia(2)
        }
    }
}

class PuniadoHongosSalvajes {
    const cantidadHongos

    method afectar(unaPersona, _unaPocion) {
        unaPersona.aumentarFuerza(cantidadHongos)
        if (cantidadHongos > 5) {
            unaPersona.disminuirResistenciaALaMitad()
        }
    }
}
class Grog {
    method afectar(unaPersona, unaPocion) {
        unaPersona.aumentarFuerza(unaPocion.cantidadIngredientes())
    }
}

class GrogXD inherits Grog {
    override method afectar(unaPersona, unaPocion) {
        super(unaPersona, unaPocion) 
        unaPersona.duplicarResistencia()
    }
}