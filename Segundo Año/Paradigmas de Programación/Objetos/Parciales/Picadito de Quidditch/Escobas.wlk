class Nimbus {
    const anioFabricacion
    var porcentajeSalud

    method velocidad() = (80 - self.aniosAntiguedad()) * porcentajeSalud

    method aniosAntiguedad() = new Date().year() - anioFabricacion

    method recibirGolpe() {
        self.perderSalud(10)
    }

    method perderSalud(unPorcentaje) {
        porcentajeSalud -= unPorcentaje
    }
}

object saetaDeFuego {
    method velocidad() = 100

    method perderSalud(_unPorcentaje) {
        // No le pasa nada
    }
}