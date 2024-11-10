class Linea {
    const consumos = []
    const packs = []
    var tipoLinea = comun
    var deuda

    method costoPromedio(fechaInicial, fechaFinal) = self.calcularPromedio(self.consumosEnRango(fechaInicial, fechaFinal))

    method costo(unosConsumos) = unosConsumos.sum{consumo => consumo.costo()}

    method calcularPromedio(unosConsumos) = self.costo(unosConsumos) / unosConsumos.size()

    method consumosEnRango(fechaInicial, fechaFinal) = consumos.filter{consumo => consumo.ocurrioEnRango(fechaInicial, fechaFinal)}

    method costoTotalUltimos30Dias() = self.costo(self.consumosUltimos30Dias())

    method consumosUltimos30Dias() = consumos.filter{consumo => consumo.ocurrioEnRango(new Date().minusMonths(1), new Date())}

    method agregarPack(unPack) {
        packs.add(unPack)
    }

    method puedeHacer(unConsumo) = packs.any{pack => pack.cubre(unConsumo)}

    method realizarConsumo(consumo) {
		if (not self.puedeHacer(consumo)) tipoLinea.accionConsumoNoRealizable(self, consumo) else self.consumirUltimoPackSatisfactorio(consumo)
	}

    method agregarConsumo(unConsumo) {
        consumos.add(unConsumo)
    }

    method consumirUltimoPackSatisfactorio(unConsumo) {
        self.ultimoPackSatisfactorio(unConsumo).consumir(unConsumo)
    }

    method ultimoPackSatisfactorio(unConsumo) = self.packsSatisfactorios(unConsumo).last()

    method packsSatisfactorios(unConsumo) = packs.filter{pack => pack.cubre(unConsumo)}

    method limpiarPacks() = packs.filter{pack => pack.estaVencido() || pack.acabado()}

    method cambiarTipo(nuevoTipo) {
        tipoLinea = nuevoTipo
    }

    method sumarDeuda(cantidadDeuda) {
		deuda += cantidadDeuda
	}
}

object comun {
	method accionConsumoNoRealizable(linea, consumo) {
		throw new DomainException(message = "No se puede realizar el consumo")
	}
}

object black {
	method accionConsumoNoRealizable(linea, consumo) {
		linea.sumarDeuda(consumo.costo())
	}
}

object platinum {
	method accionConsumoNoRealizable(linea, consumo) {
	}
}