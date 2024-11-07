class Jugador {
    var skills
    const peso
    const escoba
    const punteria
    const fuerza
    const property nivelReflejos
    const nivelVision
    const equipo
    const posicion
    var estaAturdido = false

    method nivelDeManejoDeEscoba() = skills / peso

    method velocidad() = escoba.velocidad() * self.nivelDeManejoDeEscoba()

    method habilidad()

    method lePasaElTrapo(otroJugador) = self.habilidad() >= 2 * otroJugador.habilidad()

    method esGroso() = self.habilidad() > equipo.promedioHabilidad() and self.velocidad() > mercadoEscobas.valorArbitrario()

    method esEstrellaContra(otroEquipo) = otroEquipo.jugadores().all{jugador => self.lePasaElTrapo(jugador)}

    method ganarSkills(unaCantidad) {
        skills += unaCantidad
    }

    method perderSkills(unaCantidad) {
        skills -= unaCantidad
    }

    method esCazador() = false

    method serGolpeadoPorUnaBludger() {
        self.perderSkills(2)
        escoba.recibirGolpe()
        if (self.esGroso()) {
            self.aturdirsePorUnTurno()
        }
    }

    method aturdirsePorUnTurno() {
        estaAturdido = true
    }

    method jugarTurno(_unEquipo) {
        if (estaAturdido) {
            estaAturdido = false // No juega pero se desaturde para el próximo turno
        }
    }
}

class Cazador inherits Jugador {
    var tieneLaQuaffle = false

    method tieneLaQuaffle() = tieneLaQuaffle

    override method habilidad() = self.velocidad() + skills + punteria * fuerza

    override method jugarTurno(unEquipo) {
        super(unEquipo)
        if (tieneLaQuaffle) {
            self.intentarMeterGol(unEquipo)
        }
    }
    
    method intentarMeterGol(unEquipo) {
        self.evitarBloqueos(unEquipo)
        equipo.ganarPuntos(10)
        self.ganarSkills(5)
    }

    method evitarBloqueos(unEquipo) {
        unEquipo.intentarBloquear(self)
    }

    override method esCazador() = true

    method perderQuaffle() {
        tieneLaQuaffle = false
    }

    method atraparQuaffle() {
        tieneLaQuaffle = true
    }

    method puedeBloquear(unCazador) = self.lePasaElTrapo(unCazador)

    method esBlancoUtil() = tieneLaQuaffle

    override method serGolpeadoPorUnaBludger() {
        super()
        if (tieneLaQuaffle) {
            self.perderQuaffle()
        }
    }
}

class Guardian inherits Jugador {
    override method habilidad() = self.velocidad() + skills + nivelReflejos + fuerza

    method puedeBloquear(_unCazador) = (1..3).atRandom() == 3

    method esBlancoUtil() = ! equipo.tieneLaQuaffle()
}

class Golpeador inherits Jugador {
    override method habilidad() = self.velocidad() + skills + punteria + fuerza

    override method jugarTurno(unEquipo) {
        super(unEquipo)
        const blanco = unEquipo.entregarBlancoUtil()
        if (self.puedeGolpearA(blanco)) {
            blanco.serGolpeadoPorUnaBludger()
            self.ganarSkills(1)
        }
    }

    method puedeGolpearA(unBlanco) = punteria > unBlanco.nivelReflejos() || (1..10).atRandom() >= 8

    method puedeBloquear(_unCazador) = self.esGroso()

    method esBlancoUtil() = false
}

class Buscador inherits Jugador {
    var estaBuscandoLaSnitch = true
    var cantidadTurnosContinuos = 0
    var atrapoLaSnitch = false
    var estaPersiguiendoLaSnitch = false
    var kmsRecorridos = 0
    const kmsARecorrer = 5000

    override method habilidad() = self.velocidad() + skills + nivelReflejos * nivelVision

    override method jugarTurno(unEquipo) {
        super(unEquipo)
        if (estaBuscandoLaSnitch) {
            const numeroRandom = (1..1000).atRandom()
            if (numeroRandom < self.habilidad() + cantidadTurnosContinuos) {
                cantidadTurnosContinuos = 0
                estaBuscandoLaSnitch = false
                estaPersiguiendoLaSnitch = true
            }
            else {
                cantidadTurnosContinuos += 1
            }
        }
        else if (estaPersiguiendoLaSnitch) {
            self.recorrer(self.velocidad() / 1.6)
        }
    }

    method recorrer(km) {
        kmsRecorridos += km
        if (kmsRecorridos >= kmsARecorrer) {
            kmsRecorridos = 0
            self.atraparSnitch()
        }
    }

    method atraparSnitch() {
        atrapoLaSnitch = true
        self.ganarSkills(10)
        equipo.ganarPuntos(150)
    }

    method puedeBloquear(_unCazador) = false

    method esBlancoUtil() = estaBuscandoLaSnitch || self.leFaltanMenosDe(1000)

    method leFaltanMenosDe(km) = kmsARecorrer - kmsRecorridos < km

    override method serGolpeadoPorUnaBludger() {
        super()
        self.reiniciarBusqueda()
    }

    method reiniciarBusqueda() {
        estaBuscandoLaSnitch = true
        cantidadTurnosContinuos = 0
        estaPersiguiendoLaSnitch = false
        atrapoLaSnitch = false
        kmsRecorridos = 0
    }
}

object mercadoEscobas {
    method valorArbitrario() = 7 // Por poner algo
}