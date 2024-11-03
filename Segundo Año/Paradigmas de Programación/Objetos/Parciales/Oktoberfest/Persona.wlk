// Persona.wlk
import JarraCerveza.*

class Persona {
    const peso
    const jarrasCompradas = []
    const escuchaMusicaTradicional
    const aguante
    const marcasPreferidas

    method alcoholIngerido() = jarrasCompradas.sum{jarra => jarra.litrosAlcoholAportados()}

    method estaEbria() = self.alcoholIngerido() * peso > aguante

    method quiereEntrar(unaCarpa) = unaCarpa.vendeAlguna(marcasPreferidas) && unaCarpa.cumplePreferenciaMusical(escuchaMusicaTradicional)

    method puedeEntrar(unaAtraccion) = unaAtraccion.dejaIngresar(self)

    method entrar(unaCarpa) {
        unaCarpa.validarIngreso(self)
        self.comprarJarraDeCerveza(unaCarpa.marcaVendida(), unaCarpa.capacidadCervezas())
        unaCarpa.ingresar(self)
    }

    method comprarJarraDeCerveza(unaMarca, unaCapacidad) {
        jarrasCompradas.add(new JarraDeCerveza(capacidad = unaCapacidad, marca = unaMarca))
    }

    method esEbriaEmpedernida() = self.estaEbria() && jarrasCompradas.all{jarra => jarra.esDe1Litro()}

    method consumioUnaCerveza() = jarrasCompradas.isNotEmpty()

    method reservar(unaCarpa) {
        unaCarpa.agregarAReserva(self)
    }

    method recibirCerveza(unaJarra) {
        jarrasCompradas.add(unaJarra)
    }

    method aCualesNoPuedeEntrar(unasAtracciones) = unasAtracciones.filter{atraccion => !self.puedeEntrar(atraccion)}
}