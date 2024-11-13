import Inmobiliaria.*

class Operacion {
	const inmueble
	var estado = disponible

	method comision() method zona() = inmueble.zona()

	method reservarPara(cliente){
		estado.reservarPara(self, cliente)
	}

	method concretarPara(cliente){
		estado.concretarPara(self, cliente)
	}
	
	method estado(nuevoEstado){
		estado = nuevoEstado
	}
}

class Venta inherits Operacion {
	override method comision() = inmueble.valor() * (1 + self.porcentaje() / 100)

	method porcentaje() = inmobiliaria.porcentajeDeComisionPorVenta()
}

class Alquiler inherits Operacion {
	const meses

	override method comision() = meses * inmueble.valor() / 50000
}

class EstadoDeOperacion {
	method reservarPara(operacion, cliente)
	
	method concretarPara(operacion, cliente){
		self.validarCierrePara(cliente)
		operacion.estado(cerrada)
	}
	
	method validarCierrePara(cliente){}
}

object disponible inherits EstadoDeOperacion{
	override method reservarPara(operacion, cliente){
		operacion.estado(new Reservada(clienteQueReservo = cliente))
	}
}

class Reservada inherits EstadoDeOperacion{
	const clienteQueReservo
	
	override method reservarPara(operacion, cliente){
		throw new DomainException(message = "Ya había una reserva previa")
	}

	override method validarCierrePara(cliente){
		if(cliente != clienteQueReservo)
			throw new DomainException(message = "La operación está reservada para otro cliente")
	}
}

object cerrada inherits EstadoDeOperacion{
	override method reservarPara(operacion, cliente){
		throw new DomainException(message = "Ya se cerró la operación")
	}
    
	override method validarCierrePara(cliente){
		throw new DomainException(message = "No se puede cerrar la operación más de una vez")
	}
}