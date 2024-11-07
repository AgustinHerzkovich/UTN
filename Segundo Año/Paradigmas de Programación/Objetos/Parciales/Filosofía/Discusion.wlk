class Discusion {
    const partido1
    const partido2

    method esBuena() = self.mitadDeArgumentosEnriquecedores() and self.ambosEstanEnLoCorrecto()

    method mitadDeArgumentosEnriquecedores() = partido1.mitadDeArgumentosEnriquecedores() and partido2.mitadDeArgumentosEnriquecedores()

    method ambosEstanEnLoCorrecto() = partido1.estaEnLoCorrecto() and partido2.estaEnLoCorrecto()
}

class Partido {
    const filosofo
    const argumentos = []

    method mitadDeArgumentosEnriquecedores() = self.cantidadArgumentosEnriquecedores() >= self.cantidadArgumentos() / 2

    method cantidadArgumentosEnriquecedores() = argumentos.count{argumento => argumento.esEnriquecedor()}

    method cantidadArgumentos() = argumentos.size()

    method estaEnLoCorrecto() = filosofo.estaEnLoCorrecto()
}

class Argumento {
    const descripcion
    const naturaleza

    method esEnriquecedor() = naturaleza.enriquece(self)

    method cantidadPalabras() = descripcion.words()

    method esPregunta() = descripcion.endsWith("?")
}