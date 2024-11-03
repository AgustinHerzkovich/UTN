class Humano {
    const fuerzaVoluntad
    const bando

    method puedeDerrotar(unContendiente) = self.nivelAptitud() > unContendiente.nivelAptitud()

    method nivelAptitud() = fuerzaVoluntad + bando.aptitud()

    method magia() = 0

    method vaALaLucha() = bando.humanoVaALaLucha(self)
}

class Dragon {
    const property magia
    const bando

    method nivelAptitud() = 42

    method respetaA(unPersonaje) = bando.esRespetablePara(self, unPersonaje)

    method vaALaLucha() = true

    method bendecir(unEjercito) {
        unEjercito.aumentarMoralidad(self.cantidadGuerrerosRespetables(unEjercito))
    }

    method cantidadGuerrerosRespetables(unEjercito) = unEjercito.integrantes().count{personaje => self.respetaA(personaje)}
}

class Sombra {
    const cantidadEspiritusMalignos
    const bando

    method puedeDerrotar(unContendiente) = self.magia() > unContendiente.magia()

    method nivelAptitud() = cantidadEspiritusMalignos * self.magia()

    method magia() = cantidadEspiritusMalignos * 5 + 15

    method VaALaLucha() = cantidadEspiritusMalignos >= 5
}

class Jinete inherits Humano {
    const dragon
    const habilidadNataMagica = 7

    override method puedeDerrotar(unContendiente) = super(unContendiente) and self.esDelBandoContrario(unContendiente)

    override method nivelAptitud() = super() + dragon.nivelAptitud()   

    override method magia() = habilidadNataMagica * dragon.magia() 

    method esDelBandoContrario(unContendiente) = bando != unContendiente.bando()

    override method vaALaLucha() = dragon.respetaA(self)
}