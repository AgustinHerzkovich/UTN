object estoica {
    method enriquece(_unArgumento) = true
}

object moralista {
    method enriquece(unArgumento) = unArgumento.cantidadPalabras() >= 10
}

object esceptica {
    method enriquece(unArgumento) = unArgumento.esPregunta()
}

object cinica {
    method enriquece(_unArgumento) = 1.randomUpTo(100) <= 30
}

class NaturalezaCombinada {
  const naturalezas
  method enriquece(unArgumento) = naturalezas.all {naturaleza => naturaleza.enriquece(unArgumento)}
}