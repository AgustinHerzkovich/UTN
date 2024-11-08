class Ninio {
    const property actitud
    var estadoSalud = sano
    const property elementos = []
    var cantidadCaramelos

    method capacidadDeAsustar() = self.sumatoriaSustosElementos() * estadoSalud.actitud(self)

    method sumatoriaSustosElementos() = elementos.sum{elemento => elemento.susto()}

    method intentarAsustar(unAdulto) {
        if (unAdulto.esAsustadoPor(self)) {
            unAdulto.serAsustadoPor(self)
        }
    }

    method recibirCaramelosDe(unAdulto) {
        cantidadCaramelos += unAdulto.cuantosCaramelosEntrega()
    }

    method tieneMasCaramelos(unaCantidad) = cantidadCaramelos > unaCantidad

    method cantidadCaramelos() = cantidadCaramelos

    method tieneMasCaramelosQue(otroNinio) = self.tieneMasCaramelos(otroNinio.cantidadCaramelos())

    method comerCaramelos(unaCantidad) {
        if (self.noTiene(unaCantidad)) {
            throw new DomainException(message = "No tengo tantos caramelos")
        }
        else {
            if (unaCantidad > 10) {
                self.empeorarDeEstado()
            }
            cantidadCaramelos -= unaCantidad
        }
    }

    method noTiene(unaCantidadDeCaramelos) = cantidadCaramelos < unaCantidadDeCaramelos

    method empeorarDeEstado() {
        estadoSalud.empeorar()
    }

    method modificarSalud(nuevoEstado) {
        estadoSalud = nuevoEstado
    }
}

// Estados de salud
object sano {
    method actitud(unNinio) = unNinio.actitud()

    method empeorar(unNinio) = unNinio.modificarSalud(empachado)
}

object empachado {
    method actitud(unNinio) = unNinio.actitud() / 2

    method empeorar(unNinio) = unNinio.modificarSalud(enCama)
}

object enCama {
    method actitud(_unNinio) = 0

    method empeorar(unNinio) {
        throw new DomainException(message = "No puede comer más caramelos")
    }
}