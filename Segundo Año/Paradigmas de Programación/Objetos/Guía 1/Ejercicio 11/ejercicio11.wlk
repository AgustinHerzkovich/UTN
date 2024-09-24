object libro {
    const clasificacion = informatica
    const capitulos = 10

    method cuantoTiempoSePuedePrestar() {
        return clasificacion.tiempoParaPrestar(capitulos)
    }
}

object tipoLibro {
    method tiempoParaPrestar(_capitulos) {
        return 5 // Por defecto
    }
}

object prestamoDosSemanas inherits tipoLibro {
    method tiempoParaPrestar(_capitulos) {
        return 2
    }
}

// Clases específicas de libros
object informatica inherits prestamoDosSemanas {
}

object filosofia inherits prestamoDosSemanas {
}

object matematicas inherits tipoLibro {
    method tiempoParaPrestar(capitulos) {
        if (capitulos == 1) {
            return 1
        }
        else {
            return 3
        }
    }
}