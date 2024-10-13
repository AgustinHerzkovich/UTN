import Gente.*
class Micro {
    var capacidadSentados
    var capacidadParados
    var asientosOcupados = 0
    var lugaresParadosOcupados = 0
    const personas = new Dictionary()
    const volumen

    method volumenMayorA120() = volumen > 120

    method tieneEspacioEnElPiso() = capacidadSentados > 0

    method quedanLugares(cantidadLugares) = self.capacidadTotal() > cantidadLugares

    method capacidadTotal() = capacidadSentados + capacidadParados

    method puedeSubir(persona) = self.quedanLugares(1) && persona.aceptaSubirse(self)

    method subir(persona) {
        if (self.puedeSubir(persona)) {
            self.otorgarLugar(persona)
        }
        else {
            self.error("No se puede subir a la persona")
        }
    }

    method bajar(persona) {
        if (self.estaVacio()) {
            self.error("No hay nadie para bajar")
        }
        else {
            self.liberarLugar(persona)
        }
    }

    method otorgarLugar(persona) {
        if (capacidadSentados > 0) {
            capacidadSentados -= 1
            asientosOcupados += 1
            personas.put(persona, "sentado")
        }
        else {
            capacidadParados -= 1
            lugaresParadosOcupados += 1
            personas.put(persona, "parado")
        }
    }

    method liberarLugar(persona) {
        if (personas.get(persona) == "sentado") {
            capacidadSentados += 1
            asientosOcupados -= 1
        }
        else {
            capacidadParados += 1
            lugaresParadosOcupados -= 1
        }
        personas.remove(persona)
    }

    method estaVacio() = asientosOcupados + lugaresParadosOcupados == 0
}