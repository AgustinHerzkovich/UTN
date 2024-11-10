class Pack {
    const vigencia = ilimitada

    method puedeSatisfacer(unConsumo) = ! self.estaVencido() and self.cubre(unConsumo)

    method cubre(unConsumo)

    method estaVencido() = vigencia.vencido()

    method acabado()
}

class PackConsumible inherits Pack {
    const cantidadConsumos
    const consumos = []

    method consumir(unConsumo) {
        consumos.add(unConsumo)
    }

    method cantidadConsumida() = consumos.sum{consumo => consumo.cantidad()}

    method consumosLibres() = cantidadConsumos - self.cantidadConsumida()

    override method acabado() = self.consumosLibres() <= 0
}

class CreditoDisponible inherits PackConsumible {
    const cantidadCredito

    override method cubre(unConsumo) = cantidadCredito >= unConsumo.costo()
}

class MbLibres inherits PackConsumible {
    override method cubre(unConsumo) = unConsumo.cubiertoPorInternet(self)

    method puedeGastarMB(cantidad) = cantidad <= self.consumosLibres()
}

class PackIlimitado inherits Pack {
    method consumir(_unConsumo) {
        // No se consume
	}

	method puedeGastarMB(_cantidad) = true

	method puedeGastarMinutos(_cantidad) = true

    override method acabado() = false
}

class LlamadasGratis inherits PackIlimitado {
    override method cubre(unConsumo) = unConsumo.cubiertoPorLlamada(self)
}


class InternetLibreLosFindes inherits PackIlimitado {
	override method cubre(unConsumo) = unConsumo.cubiertoPorInternet(self) and unConsumo.fecha().internalDayOfWeek() > 5
}

class MbLibresPlusPlus inherits MbLibres {
    override method puedeGastarMB(unaCantidad) = super(unaCantidad) || unaCantidad < 0.1
}

object ilimitada {
    method vencido() = false
}

class Vencimiento {

	const fecha

	method vencido() = fecha < new Date()
}