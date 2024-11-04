class Zona {
    const resistencia
    const property ataquesSufridos = []

    method resistencia()

    method nightmareTeam() = self.atacantesMasPeligrosos().asSet()

    method atacantesMasPeligrosos() = ataquesSufridos.map{ataque => ataque.monstruoMasPeligrosos()}

    method atacantesRapidos() = ataquesSufridos.map{ataque => ataque.monstruosRapidos()}.asSet()

    method fueDestruida() = ataquesSufridos.any{ataque => self.fueDestruidaPor(ataque)}

    method fueDestruidaPor(unAtaque) = unAtaque.nivelDeDevastacionMayorA(resistencia)

    method ataquesDestructivos() {
        if (self.fueDestruida()) {
            return ataquesSufridos.filter{ataque => self.fueDestruidaPor(ataque)}
        }
        else {
            throw new DomainException(message = "La zona no fue destruida")
        }
    }

    method fueDestruidaAntesDe(unMonstruo) = self.ataquesSufridos().any{ataque => ataque.participo(unMonstruo) and ataque.ocurrioAntesDeAlguno(self.ataquesDestructivos())}

    method registrarAtaque(unAtaque) {
        const ataqueFiltrado = self.filtrarAtaque(unAtaque)
        self.validarAtaque(ataqueFiltrado)
        ataquesSufridos.add(ataqueFiltrado)
    }

    method validarAtaque(unAtaque) {
        if (! unAtaque.noTieneMonstruos()) {
            throw new DomainException(message = "La zona no puede recibir ese ataque")
        }
    }

    method filtrarAtaque(unAtaque)
}

class Aldea inherits Zona{
    const casas = []

    override method resistencia() = casas.sum{casa => casa.resistencia()}

    override method filtrarAtaque(unAtaque) = unAtaque.filtrarPateticos()
    
}

class Castillo inherits Zona{
    const plusPropio

    override method resistencia() = 3000 + plusPropio

    override method filtrarAtaque(unAtaque) = unAtaque.filtrarMonstruosPeligrosidadMayorA(256)
}

class CastilloMagico inherits Castillo {
    const plusPorMago
    const magos = []

    override method resistencia() = super() + self.plusMagos() + 20

    method plusMagos() = plusPorMago * magos.size()
}