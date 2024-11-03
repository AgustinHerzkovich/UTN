class Bando {
    var aptitud
    const integrantes = []
    var puntosMoral = null

    method ejercito() = integrantes.filter{personaje => personaje.vaALaLucha()}

    method modificarAptitud(nuevaAptitud) {
        aptitud = nuevaAptitud
    }

    method lider()

    method puedeDerrotar(unBando) = self.lider().puedeDerrotar(unBando.lider())

    method modificarMoralidad(nuevaMoralidad) {
        puntosMoral = nuevaMoralidad
    }
}

object vardeno inherits Bando(aptitud = null) {
    
    method esRespetablePara(_unDragon, unPersonaje) = unPersonaje.nivelAptitud() > 30 and unPersonaje.bando() == self

    override method lider() = integrantes.max{vardeno => vardeno.nivelAptitud()}

    method humanoVaALaLucha(unHumano) = unHumano.nivelAptitud() > 18
}

object imperio inherits Bando(aptitud = null) {
    const lider = null

    method esRespetablePara(unDragon, unPersonaje) = unPersonaje.nivelAptitud() > unDragon.nivelAptitud()

    override method lider() = lider

    method humanoVaALaLucha(unHumano) = true
}