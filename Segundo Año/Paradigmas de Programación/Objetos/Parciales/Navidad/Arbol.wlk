class ArbolNavidenio {
    const regalos = []
    const tarjetas = []
    const adornos = []

    method capacidad()

    method agregarRegalo(unRegalo) {
        self.validarPoderAgregarRegalo()
        regalos.add(unRegalo)
    }

    method validarPoderAgregarRegalo() {
        if (self.capacidad() <= 0) {
            throw new DomainException(message = "El árbol no tiene capacidad para agregar el regalo")
        }
    }

    method beneficiarios() = (tarjetas + regalos).map{tarjetaORegalo => tarjetaORegalo.destinatario()}

    method costoRegalos() = regalos.sum{regalo => regalo.precio()}

    method importancia() = adornos.sum{adorno => adorno.importancia()}

    method esPortentoso() = self.cantidadRegalosTeQuierenMucho() > 5 || self.tieneTarjetaCara()

    method cantidadRegalosTeQuierenMucho() = regalos.count{regalo => regalo.regaloTeQuierenMucho()}

    method tieneTarjetaCara() = tarjetas.any{tarjeta => tarjeta.valorAdjunto() >= 1000}

    method adornoMasPesado() = adornos.max{adorno => adorno.peso()}
}

class ArbolNatural inherits ArbolNavidenio {
    const vejez
    const tamanioTronco

    override method capacidad() = vejez * tamanioTronco
}

class ArbolArtificial inherits ArbolNavidenio {
    const cantidadVaras

    override method capacidad() = cantidadVaras
}