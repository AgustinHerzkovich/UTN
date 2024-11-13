class Objetivo {
    method serInvadidoPor(expedicion) {
		expedicion.repartirBotin(self.botin(expedicion.cantidadIntegrantes()))
		self.destruirse(expedicion.cantidadIntegrantes())

	}

	method destruirse(cantidadInvasores)
	method botin(cantidadInvasores)
}

class Capital inherits Objetivo {
    const factorRiqueza
    var defensores

    method valeLaPena(cantidadInvasores) = self.botin(cantidadInvasores) / cantidadInvasores >= 3

    override method botin(cantidadInvasores) = self.defensoresDerrotados(cantidadInvasores) * factorRiqueza

    method defensoresDerrotados(cantidadInvasores) = defensores.min(cantidadInvasores)

    override method destruirse(cantidadInvasores) {
        defensores -= self.defensoresDerrotados(cantidadInvasores)
    }

    override method serInvadidoPor(expedicion) {
        expedicion.aumentarVidasCobradasEn(self.defensoresDerrotados(expedicion.cantidadVikingos()))
        super(expedicion)
    }
}

class Aldea inherits Objetivo {
    var cantidadCrucifijos

    method valeLaPena(cantidadInvasores) = self.saciaLaSedDeSaqueos(self.botin(cantidadInvasores))

    override method botin(cantidadInvasores) = cantidadCrucifijos

    method saciaLaSedDeSaqueos(monedas) = monedas >= 15

    override method destruirse(cantidadInvasores) {
        cantidadCrucifijos = 0
    }
}

class AldeaAmurallada inherits Aldea {
    const cantidadMinima

    override method valeLaPena(cantidadInvasores) = super(cantidadInvasores) and cantidadInvasores >= cantidadMinima
}

/*
4. Pueden agregarse los castillos creando una clase Castillo y haciendo que entienda los mensajes
"valeLaPena", "botin" y "serInvadidoPor" para poder ser tratados polimórficamente por las expediciones.
*/