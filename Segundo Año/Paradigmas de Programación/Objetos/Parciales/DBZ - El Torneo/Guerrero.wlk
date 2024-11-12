// Guerrero.wlk
class Guerrero {
    var potencialOfensivo
    var energia
    const energiaOriginal = energia
    var experiencia
    const traje

    method atacar(guerrero) {
        guerrero.recibirAtaque(potencialOfensivo)
    }

    method potencialOfensivo() = potencialOfensivo

    method recibirAtaque(potencial) {
        traje.defender(self, self.energiaPerdidaDeUnGolpe(potencial))
        experiencia +=1
    }

    method energiaPerdidaDeUnGolpe(potencial) = potencial * 0.1

    method morir() {
        energia = 0
    }

    method comerSemillaErmitanio() {
        self.restaurarEnergia()
    }

    method aumentarExperiencia(porcentaje) {
        experiencia += experiencia * porcentaje / 100
    }

    method sufrirDanio(danio) {
        energia -= danio
    }
    
    method restaurarEnergia() {
        energia = energiaOriginal
    }

    method aumentarAtaque(porcentaje) {
        potencialOfensivo += potencialOfensivo * porcentaje / 100
    }

    method cantidadElementosEnTraje() = traje.cantidadElementos()
}

class Saiyan inherits Guerrero {
    const nivel
    method convertirse() {
        self.aumentarAtaque(50)
    }

    override method energiaPerdidaDeUnGolpe(potencial) = nivel.energiaPerdida(potencial)

    override method comerSemillaErmitanio() {
        self.aumentarAtaque(5)
    }
}

object nivel1 {
    method energiaPerdida(potencial) = potencial * 0.95
}

object nivel2 {
    method energiaPerdida(potencial) = potencial * 0.93
}

object nivel3 {
    method energiaPerdida(potencial) = potencial * 0.85
}