class Disfraz {
    const caracteristicas = []
    const nombre
    const fechaConfeccion
    const property nivelGracia

    method puntaje(fiesta, persona) = caracteristicas.sum{caracteristica => caracteristica.puntaje(self, fiesta, persona)}

    method antiguedad() = new Date() - fechaConfeccion

    method tieneMasDe50Anios() = self.antiguedad().year() > 50

    method nombreConLetrasPares() = nombre.size().even()

    method estaHechoHaceMenosDe30Dias() = self.antiguedad().day() < 30

    method existe() = true
}

// Características
object gracioso {
    method puntaje(disfraz, _fiesta, _persona) = disfraz.nivelGracia() * self.plusEdad(disfraz)

    method plusEdad(disfraz) = if (disfraz.tieneMasDe50Anios()) 3 else 1
}

class Tobara {
    const diaComprado

    method puntaje(_disfraz, fiesta, _persona) = if (fiesta.ocurre2OMasDiasDespuesDe(diaComprado)) 5 else 3
}

class Careta {
    const personaje

    method puntaje() = personaje.puntaje()
}

object sexie {
    method puntaje(_disfraz, _fiesta, persona) = if (persona.esSexie()) 15 else 2
}

class DisfrazInexistente inherits Disfraz {
    override method existe() = false
}

// Personajes
object mickeyMouse {
    method puntaje() = 8
}

object osoCarolina {
    method puntaje() = 6
}