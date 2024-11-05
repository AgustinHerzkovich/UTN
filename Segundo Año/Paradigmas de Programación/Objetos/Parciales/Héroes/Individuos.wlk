import Poderes.*

class Individuo {
    var nivelEntrenamiento
    const armas = []
    const historialOponentes = []
    const topeEntrenamiento = 1000

    method potencia() = nivelEntrenamiento + self.armaMasPoderosa().potencia()

    method armaMasPoderosa() = armas.max{arma => arma.potencia()}

    method pelearCon(unOponente) {
        if (self.puedeGanarleA(unOponente)) {
            self.ganarPelea(unOponente)
        } else {
            unOponente.ganarPelea(self)
        }
        self.registrarOponente(unOponente)
    }

    method puedeGanarleA(unOponente) = self.potencia() > unOponente.potencia()

    method ganarPelea(vencido) {
        self.aumentarNivelEntrenamiento()
    }

    method aumentarNivelEntrenamiento() {
        nivelEntrenamiento = topeEntrenamiento.min(nivelEntrenamiento + 1)
    }

    method poderOtorgado() = new SuperFuerza(potencia = 5)

    method registrarOponente(unOponente) {
        historialOponentes.add(unOponente)
    }

    method esDignoDeConfianza() = self.realizoMasDeNPeleas(10) and self.noLlegoAlTopeDeEntrenamiento()

    method realizoMasDeNPeleas(cantidad) = self.cantidadPeleas() > cantidad

    method cantidadPeleas() = historialOponentes.size()

    method noLlegoAlTopeDeEntrenamiento() = nivelEntrenamiento < topeEntrenamiento

    method oponenteMasPoderosoEnfrentado() = historialOponentes.max{oponente => oponente.potencia()}

    method tieneMasPeleasQue(unIndividuo) = self.cantidadPeleas() > unIndividuo.cantidadPeleas()
}

class Heroe inherits Individuo {
    const poder

    override method potencia() = super() + poder.potencia()

    override method ganarPelea(vencido) {
        poder.aumentarHabilidades(vencido)
    }

    override method poderOtorgado() = poder

    override method esDignoDeConfianza() = super() and poder.esDignoDeConfianza()
}