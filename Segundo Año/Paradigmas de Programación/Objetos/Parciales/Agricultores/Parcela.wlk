import Capataz.*

class Parcela {
    const property tamanio
    const property costo
    var cultivo
    var cantidadCultivoEnParcela
    var cantidadCultivoEnSilo
    const registroVentas = []
    const capataz

    method costoCultivo() = self.costoPorHectarea() * cantidadCultivoEnParcela

    method costoPorHectarea() = cultivo.costoPorHectarea(self) 

    method cultivo() = cultivo

    method precioPorKg() = cultivo.precioPorKg(self)

    method aumentarCultivoEnParcela() {
        cantidadCultivoEnParcela += 1
    }

    method disminuirCultivoEnParcela() {
        cantidadCultivoEnParcela = 0
    }

    method subirCultivoEnSilo(unaCantidad) {
        cantidadCultivoEnSilo += cultivo.kilosPorHectareaCultivada(unaCantidad)
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

    method vender(cantidadKilos, comprador, fecha) {
        capataz.vender(cultivo, cantidadKilos, comprador, fecha, self)
    }

    method registrarVenta(unaFecha, unCultivo, kilos, unComprador, precioVenta) {
        self.validarVentaNoExcesiva(kilos)
        registroVentas.add(new Venta(fecha = unaFecha, cultivo = unCultivo, cantidadKilos = kilos, comprador = unComprador, precio = precioVenta))
        self.bajarCultivoEnSilo(kilos)
    }

    method facturacionEnRango(fecha1, fecha2) = registroVentas.filter{venta => venta.estaEntre(fecha1, fecha2)}.sum{venta => venta.precio()}

    method estaSubutilizada() = cantidadCultivoEnParcela < tamanio / 2

    method validarVentaNoExcesiva(kilos) {
        if (kilos > cantidadCultivoEnSilo) {
            throw new DomainException(message = "No hay suficiente cultivo en el silo")
        }
    }
}