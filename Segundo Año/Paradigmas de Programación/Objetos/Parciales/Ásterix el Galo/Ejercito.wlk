import Formaciones.*

class Ejercito {
    const integrantes = #{}

    method poder() = self.integrantesEnCombate().sum{integrante => integrante.poder()}

    method integrantesEnCombate() = integrantes.filter{integrante => !integrante.estaFueraDeCombate()}

    method recibirDanio(unaCantidad) {
        self.integrantesQueVanAdelante().forEach{integrante => integrante.recibirDanio(unaCantidad / self.cantidadIntegrantesAdelante())}
    }

    method cantidadIntegrantesAdelante() = 10

    method integrantesQueVanAdelante() = if (self.cantidadIntegrantes() < self.cantidadIntegrantesAdelante()) integrantes else self.integrantesOrdenadosPorPoder().take(self.cantidadIntegrantesAdelante())

    method integrantesOrdenadosPorPoder() = integrantes.sortedBy{integrante1, integrante2 => integrante1.esMasPoderosoQue(integrante2)}

    method cantidadIntegrantes() = integrantes.size()

    method pelearContra(unEnemigo) {
        self.validarIntegrantesEnCombate()
        self.menosPoderoso().recibirDanio(self.diferenciaDePoderCon(unEnemigo))
    }

    method validarIntegrantesEnCombate() {
        if (self.todosFueraDeCombate()) {
            throw new DomainException(message = "El ejército no puede pelear porque todos sus integrantes están fuera de combate")
        }
    }

    method todosFueraDeCombate() = integrantes.all{integrante => integrante.estaFueraDeCombate()}

    method menosPoderoso() = integrantes.min{integrante => integrante.poder()}

    method diferenciaDePoderCon(unEnemigo) = (self.poder() - unEnemigo.poder()).abs()
}

class Legion inherits Ejercito {
    var formacion
    const minimoPoder

    method adoptarFormacion(unaFormacion) {
        formacion = unaFormacion
    }

    override method recibirDanio(unaCantidad) {
        super(unaCantidad)
        if (self.poder() < minimoPoder) {
            self.adoptarFormacion(tortuga)
        }
    }

    override method poder() = formacion.poder(self)

    override method cantidadIntegrantesAdelante() = formacion.cantidadIntegrantesAdelante(self)
}