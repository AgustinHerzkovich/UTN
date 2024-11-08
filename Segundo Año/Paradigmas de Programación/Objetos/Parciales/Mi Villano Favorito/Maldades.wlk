import Arma.*
class Maldad {
    var minionsAsignados = []

    method asignarMinions(unosMinions) {
        minionsAsignados = unosMinions
    }

    method estaCapacitado(unMinion)

    method serRealizadaEn(unaCiudad) {
        if (minionsAsignados.isEmpty()) {
            throw new DomainException(message = "No hay minions asignados para la maldad")
        }
        minionsAsignados.forEach{minion => minion.agregarMaldad(self)}
    }

    method premiarMinionsConBananas(unasBananas) {
        minionsAsignados.forEach{minion => minion.alimentar(unasBananas)}
    }
}

class Congelar inherits Maldad {
    const nivelConcentracion

    override method estaCapacitado(unMinion) = unMinion.tieneArma("rayoCongelante") and unMinion.tieneConcentracionMayorA(nivelConcentracion)

    override method serRealizadaEn(unaCiudad) {
        super(unaCiudad)
        unaCiudad.disminuirTemperatura(30)
        self.premiarMinionsConBananas(10)
    }
}

class Robar inherits Maldad {
    const objetivo

    override method estaCapacitado(unMinion) = unMinion.esPeligroso() and objetivo.estaCapacitado(unMinion)

    override method serRealizadaEn(unaCiudad) {
        super(unaCiudad)
        unaCiudad.perderItem(objetivo)
        objetivo.realizarsePor(self)
    }

    method mutantizarMinions() {
        minionsAsignados.forEach{minion => minion.absorberSueroMutante()}
    }

    method otorgarArma(unArma) {
        minionsAsignados.forEach{minion => minion.otorgarArma(unArma)}
    }
}

// Objetivos de robo
class Piramide {
    const altura

    method realizarsePor(unRobo) {
        unRobo.premiarMinionsConBananas(10)
    }

    method estaCapacitado(unMinion) = unMinion.tieneConcentracionMayorA(altura / 2)
}

object sueroMutante {
    method realizarsePor(unRobo) {
        unRobo.mutantizarMinions()
    }

    method estaCapacitado(unMinion) = unMinion.estabienAlimentado() and unMinion.tieneConcentracionMayorA(23)
}

object laLuna {
    method realizarsePor(unRobo) {
        unRobo.OtorgarArma(new Arma(nombre = "rayoCongelante", potencia = 10))
    }

    method estaCapacitado(unMinion) = unMinion.tieneArma("rayoParaEncoger")
}