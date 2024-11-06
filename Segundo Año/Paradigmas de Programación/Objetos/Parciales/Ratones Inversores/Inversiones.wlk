class ComprarCompania {
    const compania
    const porcentaje

    method costo() = self.recaudacionTotalPeliculas() * porcentaje

    method recaudacionTotalPeliculas() = compania.recaudacionPeliculas()

    method personajesInvolucrados() = compania.personajes()
}

class ConstruirParqueDeDiversiones {
    const atracciones = []
    var costoMetroCuadrado
    const superficie

    method costo() = self.costoAtracciones() + costoMetroCuadrado * superficie

    method modificarCostoMetroCuadrado(nuevoCosto) {
        costoMetroCuadrado = nuevoCosto
    }

    method costoAtracciones() = atracciones.sum{atraccion => atraccion.costo()}

    method personajesInvolucrados() = []
}

class ProducirUnaPelicula {
    const costoProduccion
    const pelicula

    method costo() = costoProduccion + pelicula.sueldoCadaPersonaje()

    method personajesInvolucrados() = pelicula.personajes()
    
}

class Compania {
    const peliculas = []

    method recaudacionPeliculas() = peliculas.sum{pelicula => pelicula.recaudacion()}

    method personajes() = peliculas.flatMap{pelicula => pelicula.personajes()}
}

class Atraccion {
    const property costo
}

class Pelicula {
    const property personajes = []

    method sueldoCadaPersonaje() = personajes.sum{personaje => personaje.sueldo()}
}

class PeliculaIndependiente inherits Pelicula {
    override method sueldoCadaPersonaje() = personajes.take(4).sum{personaje => personaje.sueldo()}
}