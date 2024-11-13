class Zona {
	var property valor
}

class Inmueble {
  const tamanio
  const cantAmbientes
  const zona

  method valor() = self.valorParticular() + zona.valor()

  method valorParticular()

  method zona() = zona
  
  method validarQuePuedeSerVendido(){}
}

class Casa inherits Inmueble {
	const valorParticular
	
	override method valorParticular() = valorParticular
}

class PH inherits Inmueble {
	override method valorParticular() = (14000 * tamanio).max(50000)
}

class Departamento inherits Inmueble {
	override method valorParticular() = 350000 * cantAmbientes
}

class Local inherits Casa {
	const tipoDeLocal

	override method valor() = tipoDeLocal.valorFinal(super())

	override method validarQuePuedeSerVendido(){
		throw new DomainException(message = "No se puede vender un local")
	}
}

object galpon {
	method valorFinal(valorBase) = valorBase / 2
}

object aLaCalle {
	var property montoFijo = 0
	
	method valorFinal(valorBase) = valorBase + montoFijo
}