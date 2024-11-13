class Expedicion {
    const vikingos = #{}
    const objetivos = []

    method subirVikingo(unVikingo) {
        self.validarSubida(unVikingo)
        vikingos.add(unVikingo)
    }

    method validarSubida(unVikingo) {
        if (! unVikingo.puedeSubirAUnaExpedicion()) {
            throw new DomainException(message = "El vikingo no puede subir a la expedición")
        }
    }

    method valeLaPena() = objetivos.all{objetivo => objetivo.valeLaPena(self.cantidadVikingos())}

    method cantidadVikingos() = vikingos.size()

    method realizar() {
        objetivos.forEach{objetivo => objetivo.serInvadidoPor(self.cantidadVikingos())}
    }

    method aumentarVidasCobradasEn(cantidad) { 
		vikingos.take(cantidad).forEach{vikingo => vikingo.cobrarVida()}
	}

    method repartirBotin(botin) {
        vikingos.forEach{vikingo => vikingo.ganarBotin(botin / self.cantidadVikingos())}
    }

    method botinTotal() = objetivos.sum{objetivo => objetivo.botin()}
}