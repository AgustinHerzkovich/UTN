import Capataz.*

class Parcela {
    const property tamanio
    const property costo
    var cultivo
    var cantidadCultivoEnParcela
    var cantidadCultivoEnSilo
    const registroVentas = []

    method costoCultivo() = self.costoPorHectarea() * cantidadCultivoEnParcela

    method costoPorHectarea() = cultivo.costoPorHectarea(self) 

    method precioPorKg() = cultivo.precioPorKg(self)

    method aumentarCultivoEnParcela() {
        cantidadCultivoEnParcela += 1
    }

    method disminuirCultivoEnParcela() {
        cantidadCultivoEnParcela -= 1
    }

    method subirCultivoEnSilo(unaCantidad) {
        cantidadCultivoEnSilo += unaCantidad
    }

    method bajarCultivoEnSilo(unaCantidad) {
        cantidadCultivoEnSilo -= unaCantidad
    }

    method cambiarCultivo(nuevoCultivo) {
        self.validarCambioDeCultivo()
        cultivo = nuevoCultivo
    }

    method validarCambioDeCultivo() {
        if (! self.permiteCambioDeCultivo()) {
            throw new DomainException(message = "No se permite el cambio de cultivo")
        }
    }

    method permiteCambioDeCultivo() = cantidadCultivoEnParcela == 0 && cantidadCultivoEnSilo == 0

    method cantidadCultivoEnParcela() = cantidadCultivoEnParcela

    method registrarVenta(unaFecha, unCultivo, kilos, unComprador) {
        registroVentas.add(new Venta(fecha = unaFecha, cultivo = unCultivo, cantidadKilos = kilos,comprador = unComprador))
    }
}


