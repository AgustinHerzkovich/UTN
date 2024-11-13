class Persona {
	const suenios = []
    var cantidadHijos
    const lugaresVisitados = []
    const carrerasPendientes = []
    const carrerasCompletadas = [] 
    const plataRequerida
    var felicidad
    var plataGanada
    const tipo
	
	method cumplir(suenio) {
		if (!self.sueniosPendientes().contains(suenio)) {
			throw new DomainException(message = "El sueño " + suenio + " no está pendiente")
		}
		suenio.cumplir(self)
	}
	
	method sueniosPendientes() = suenios.filter {suenio => suenio.estaPendiente()}

    method agregarHijos(hijos) {
        cantidadHijos += hijos
    }

    method tieneHijos() = cantidadHijos > 0

    method viajarA(lugar) {
        lugaresVisitados.add(lugar)
    }

    method seRecibioDe(carrera) = carrerasCompletadas.contains(carrera)

    method quiereEstudiar(carrera) = carrerasPendientes.contains(carrera) 

    method completarCarrera(carrera) {
        carrerasCompletadas.add(carrera)
    }

    method quiereGanarMas(plata) = plataRequerida > plata

    method sumarFelicidad(felicidonios) {
        felicidad += felicidonios
    }

    method ganarPlata(plata) {
        plataGanada += plata
    }

    method cumplirSuenioMasPreciado() {
        self.cumplir(tipo.elegirSuenio(self.sueniosPendientes()))
    }

    method esFeliz() = felicidad > self.sumaFelicidoniosSueniosPendientes()

    method sumaFelicidoniosSueniosPendientes() = self.sueniosPendientes().sum{suenio => suenio.felicidonios()}

    method esAmbiciosa() = self.cantidadSueniosFelices() > 3

    method cantidadSueniosFelices() = self.sueniosFelices().size()

    method sueniosFelices() = suenios.filter{suenio => suenio.felicidonios() > 100}
}

// Tipos de persona
object realista {
    method elegirSuenio(suenios) = suenios.max{suenio => suenio.felicidonios()}
}

object alocado {
    method elegirSuenio(suenios) = suenios.anyOne()
}

object obsesivo {
    method elegirSuenio(suenios) = suenios.first()
}