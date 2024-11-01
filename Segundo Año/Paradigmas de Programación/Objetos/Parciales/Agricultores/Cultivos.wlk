class Cultivo {
    method kilosPorHectareaCultivada()
}

class Soja inherits Cultivo {
    method costoPorHectarea(_parcela) = 10

    method precioPorKg(parcela) = 10 * parcela.costo() * (1 - self.retencion(parcela.tamanio())) 

    method retencion(tamanio) = if (tamanio > 1000) 0.1 else 0
}

class SojaTransgenica inherits Soja {
    const puedeSufrirMutacionesGeneticas = false

    override method precioPorKg(_parcela) = if (puedeSufrirMutacionesGeneticas) super(_parcela) / 2 else super(_parcela)
}

class Trigo inherits Cultivo {
    const costoConservantes

    method costoPorHectarea(parcela) = if (parcela.tamanio() * 5 < 500) 5 else 500 / parcela.tamanio()

    method precioPorKg(_parcela) = 20 - costoConservantes
}

class Sorgo inherits Cultivo {
    method costoPorHectarea(parcela) = if (parcela.cantidadCultivoEnParcela() < 50) 3 else 2

    method precioPorKg(_parcela) = 20
}