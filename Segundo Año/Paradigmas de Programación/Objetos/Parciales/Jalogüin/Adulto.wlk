class AdultoComun {
    const niniosAsustadores = #{}

    method esAsustadoPor(unNinio) = self.tieneToleranciaMenorA(unNinio.capacidadDeAsustar())

    method serAsustadoPor(unNinio) {
        niniosAsustadores.add(unNinio)
        unNinio.recibirCaramelosDe(self)
    }

    method tieneToleranciaMenorA(unValor) = self.tolerancia() < unValor

    method cuantosCaramelosEntrega() = self.tolerancia() / 2

    method tolerancia() = 10 * self.cantidadDeNiniosCon15CaramelosQueIntentaronAsustarloAntes()

    method cantidadDeNiniosCon15CaramelosQueIntentaronAsustarloAntes() = niniosAsustadores.filter{ninio => ninio.tieneMasCaramelos(15)}.size()
}

class Abuelo inherits AdultoComun {
    override method esAsustadoPor(_unNinio) = true

    override method cuantosCaramelosEntrega() = super() / 2
}

class AdultoNecio inherits AdultoComun {
    override method esAsustadoPor(_unNinio) = false
}

