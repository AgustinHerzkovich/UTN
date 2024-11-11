import Personalidades.*
import Casa.*

class Personaje {
    const conyuges = []
    const property casa
    const acompaniantes = []
    var estaVivo = true
    const personalidad

    method estaSoltero() = conyuges.isEmpty()

    method esDeDistintaCasa(otroPersonaje) = casa != otroPersonaje.casa()

    method puedeCasarseCon(otroPersonaje) = casa.admiteCasamiento(self, otroPersonaje)

    method casarseCon(otroPersonaje) {
        self.validarCasamiento(otroPersonaje)
        conyuges.add(otroPersonaje)
    }

    method validarCasamiento(otroPersonaje) {
        if (! self.puedeCasarseCon(otroPersonaje) || otroPersonaje == null) {
            throw new DomainException(message = "No puede realizarse el casamiento")
        }
    }

    method patrimonio() = casa.patrimonioIndividual()

    method estaSolo() = acompaniantes.isEmpty()

    method aliados() = acompaniantes + conyuges + casa.miembros()

    method esPeligroso() = estaVivo and (self.aliadosRicos() || self.conyugesRicos() || self.alianzaPeligrosa())

    method aliadosRicos() = self.aliados().sum{aliado => aliado.patrimonio()} >= 10000

    method conyugesRicos() = conyuges.all{conyuge => conyuge.esDeCasaRica()}

    method esDeCasaRica() = casa.esRica()

    method alianzaPeligrosa() = self.aliados().any{aliado => aliado.esPeligroso()}

    method esAliadoDe(unPersonaje) = self.aliados().contains(unPersonaje)

    method ejecutarAccionConspirativa(unObjetivo) = personalidad.conspirarContra(unObjetivo)

    method estaVivo() = estaVivo

    method morirse() {
        estaVivo = false
    }

    method derrochar(unPorcentaje) {
        casa.perderDinero(unPorcentaje)
    }
}

class Animal {
    method patrimonio() = 0
}

class Dragon inherits Animal {
    method esPeligroso() = true
}

object huargo inherits Animal {
    method esPeligroso() = true
}

object hodor inherits Personaje(casa = stark, personalidad = miedoso) {
    override method esPeligroso() = false
}