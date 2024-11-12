class Torneo {
    const guerreros = []
    const modalidad

    method participantes() = modalidad.seleccionarParticipantes(guerreros)
}

// Modalidades
object powerlsBest {
    method seleccionarParticipantes(guerreros) = guerreros.sortedBy{guerrero1, guerrero2 => guerrero1.potencialOfensivo() > guerrero2.potencialOfensivo()}.take(16)
}

object funny {
    method seleccionarParticipantes(guerreros) = guerreros.sortedBy{guerrero1, guerrero2 => guerrero1.cantidadElementosEnTraje() > guerrero2.cantidadElementosEnTraje()}.take(16)
}

object surprise {
    method seleccionarParticipantes(guerreros) = guerreros.randomized().take(16)
}