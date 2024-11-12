class Emocion {
    method niega(_recuerdo) = false

    method esAlegre() = false

    method asentarse(_recuerdo, _persona) {

    }
}

object alegria inherits Emocion{
    override method niega(recuerdo) = ! recuerdo.esAlegre()

    override method esAlegre() = true

    override method asentarse(recuerdo, persona) {
        if (persona.nivelFelicidad() > 500) {
            persona.agregarPensamientoCentral(recuerdo)
        } 
    }
}

object tristeza inherits Emocion {
    override method niega(recuerdo) = recuerdo.esAlegre()

    override method asentarse(recuerdo, persona) {
        persona.agregarPensamientoCentral(recuerdo)
        persona.disminuirFelicidad(10)
    }
}

class EmocionCompuesta {
    const emociones = []

    method niega(recuerdo) = emociones.all{emocion => emocion.niega(recuerdo)}

    method esAlegre() = emociones.any{emocion => emocion.esAlegre()}

    method asentarse(recuerdo, persona) {
        emociones.forEach{emocion => emocion.asentarse(recuerdo, persona)}
    }
}
