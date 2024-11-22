class Panelista {
    var puntosEstrella = 0

    method darRemateGracioso(unaTematica) {
        self.incrementarPuntosEstrella(self.puntosPorRemate(unaTematica))
    }

    method puntosPorRemate(unaTematica)

    method incrementarPuntosEstrella(unaCantidad) {
        puntosEstrella += unaCantidad
    }

    method opinarSobre(unaTematica) {
        self.incrementarPuntosEstrella(1)
    }

    method puntosEstrella() = puntosEstrella

    method salirAlAire(unaTematica) {
        self.opinarSobre(unaTematica)
        self.darRemateGracioso(unaTematica)
    }
}

class Celebridad inherits Panelista {
    override method puntosPorRemate(unaTematica) = 3

    override method opinarSobre(unaTematica) {
        self.incrementarPuntosEstrella(unaTematica.puntosFaranduleros(self))
    }
}

class Colorado inherits Panelista {
    var gracia

    override method puntosPorRemate(unaTematica) = gracia / 5

    override method darRemateGracioso(unaTematica) {
        super(unaTematica)
        self.incrementarGracia(1)
    }

    method incrementarGracia(unaCantidad) {
        gracia += unaCantidad
    }
}

class ColoradoConPeluca inherits Colorado {
    override method puntosPorRemate(unaTematica) = super(unaTematica) + 1
}

class Viejo inherits Panelista {
    override method puntosPorRemate(unaTematica) = unaTematica.cantidadPalabrasTitulo()
}

class Deportivo inherits Panelista {
    override method puntosPorRemate(unaTematica) = 0

    override method opinarSobre(unaTematica) {
        self.incrementarPuntosEstrella(unaTematica.puntosDeportivos())
    }
}

/*
Decidí utilizar herencia y no composición, dado que tengo el caso de Colorado, donde no sólo me da una cantidad de puntos por el remate, 
sino que además, incrementa su cantidad de gracia, por lo que debería retornar y a la vez tener efecto, y para evitar esto, decidí hacer que
cada tipo de panelista sea una subclase de Panelista y que cada uno implemente el método puntosPorRemate(), y luego el método darRemateGracioso lo
overrideo en Colorado para que además de incrementarse la cantidad de estrellas, se incremente la gracia.
*/