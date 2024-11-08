class Minion {
    var color = amarillo
    var bananas
    const armas = []
    const maldades = []

    method esPeligroso() = color.esPeligroso(self)

    method tieneMasDe2Armas() = self.cantidadArmas() > 2

    method cantidadArmas() = armas.size()

    method absorberSueroMutante() {
        color.absorberSueroMutante(self)
    }

    method convertirseEnVioleta() {
        color = violeta
        armas.clear()
        bananas -= 1
    }

    method convertirseEnAmarillo() {
        color = amarillo
        bananas -= 1
    }

    method nivelDeConcentracion() = color.nivelDeConcentracion(self)

    method potenciaArmaMasPotente() = self.armaMasPotente().potencia()

    method armaMasPotente() = armas.max{arma => arma.potencia()}

    method cantidadBananas() = bananas

    method otorgarArma(unArma) {
        armas.add(unArma)
    }

    method alimentar(unasBananas) {
        bananas += unasBananas
    }

    method tieneArma(nombreArma) = armas.any{arma => arma.nombre() == nombreArma}

    method tieneConcentracionMayorA(unNivel) = self.nivelDeConcentracion() >= unNivel

    method estaBienAlimentado() = bananas >= 100

    method agregarMaldad(unaMaldad) {
        maldades.add(unaMaldad)
    }

    method cantidadMaldadesRealizadas() = maldades.size()

    method noParticipoEnNingunaMaldad() = self.cantidadMaldadesRealizadas() == 0
}

// Colores
object amarillo {
    method esPeligroso(unMinion) = unMinion.tieneMasDe2Armas()

    method absorberSueroMutante(unMinion) = unMinion.convertirseEnVioleta()

    method nivelDeConcentracion(unMinion) = unMinion.potenciaArmaMasPotente() + unMinion.cantidadBananas()
}

object violeta {
    method esPeligroso(_unMinion) = true

    method absorberSueroMutante(unMinion) = unMinion.convertirseEnAmarillo()

    method nivelDeConcentracion(unMinion) = unMinion.cantidadBananas()
}