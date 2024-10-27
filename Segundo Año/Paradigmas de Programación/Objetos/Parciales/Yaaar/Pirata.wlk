class Pirata {
    const items = []
    var monedas
    var nivelEbriedad
    const property invitante

    method nivelEbriedad() = nivelEbriedad

    method esUtilPara(unaMision) = unaMision.esUtil(self)

    method tieneAlgunoDeEstosItems(unosItems) = unosItems.any{item => self.tieneItem(item)}

    method tieneMenosDeNMonedas(n) = monedas < n

    method tieneAlMenos10Items() = items.size() >= 10

    method tieneItem(unItem) = items.contains(unItem)

    method seAnimaASaquear(unaVictima) = unaVictima.puedeSerSaqueadaPor(self)

    method solicitarIncorporacion(unBarco) = unBarco.incorporarALaTripulacion(self)

    method tomarTragoDeGrogXD() {
        monedas -= 1
        nivelEbriedad += 5
    }

    method tieneNivelDeEbriedadMinimo(unNivel) = nivelEbriedad >= unNivel

    method estaPasadoDeGrogXD() = self.tieneNivelDeEbriedadMinimo(90)

    method dinero() = monedas
}

class EspiaDeLaCorona inherits Pirata {
    override method estaPasadoDeGrogXD() = false

    override method seAnimaASaquear(unaVictima) = super(unaVictima) && self.tieneItem("permiso de la corona")
}