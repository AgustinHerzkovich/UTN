// Carpa.wlk
import JarraCerveza.*

class Carpa {
    const property marcaVendida
    const tieneBandaTradicional
    var limitePersonas
    const property capacidadCervezas
    const personas = []

    method vendeAlguna(marcasCerveza) = marcasCerveza.any{marca => marca == marcaVendida}

    method cumplePreferenciaMusical(leGustaMusicaTradicional) = leGustaMusicaTradicional == tieneBandaTradicional

    method dejaIngresar(unaPersona) = self.hayLimiteDisponible() && ! unaPersona.estaEbria() && unaPersona.quiereEntrar(self)

    method validarIngreso(unaPersona) {
        if (!self.dejaIngresar(unaPersona)) {
            throw new DomainException(message = "No puede ingresar a la carpa")
        }
    }

    method hayLimiteDisponible() = limitePersonas > 0    

    method ingresar(unaPersona) {
        personas.add(unaPersona)
        limitePersonas -= 1
    }

    method cuantosEbriosEmpedernidosHay() = personas.count{persona => persona.esEbriaEmpedernida()}
}

class CarpaConReserva inherits Carpa {
    const personasConReserva = []

    override method dejaIngresar(unaPersona) = super(unaPersona) && unaPersona.hizoUnaReserva()

    method agregarAReserva(unaPersona) {
        personasConReserva.add(unaPersona)
    }

    override method ingresar(unaPersona) {
        super(unaPersona)
        unaPersona.recibirCerveza(new JarraDeCerveza(capacidad = 0.3, marca = marcaVendida))
    }
}