class Tematica {
    const titulo

    method cantidadPalabrasTitulo() = self.titulo().words().size()

    method puntosDeportivos() = 1

    method puntosFaranduleros(unPanelista) = 1

    method esInteresante() = false

    method tituloIncluye(unaPalabra) = self.titulo().contains(unaPalabra)

    method titulo() = titulo
}

class Deportiva inherits Tematica {
    override method puntosDeportivos() = 5

    override method esInteresante() = self.tituloIncluye("Messi")
}

class Farandula inherits Tematica {
    const involucrados = #{}
    
    override method puntosFaranduleros(unPanelista) = if (self.estaInvolucrado(unPanelista)) self.cantidadInvolucrados() else super(unPanelista)

    method estaInvolucrado(unPanelista) = involucrados.contains(unPanelista)

    method cantidadInvolucrados() = involucrados.size()

    override method esInteresante() = self.cantidadInvolucrados() >= 3
}

class Filosofica inherits Tematica {
    override method esInteresante() = self.cantidadPalabrasTitulo() > 20
}

class Mixta inherits Tematica {
    const tematicas = []

    override method titulo() = tematicas.map{tematica => tematica.titulo()}.join(" ")

    override method esInteresante() = tematicas.any{tematica => tematica.esInteresante()}

    override method puntosDeportivos() = tematicas.sum{tematica => tematica.puntosDeportivos()}

    override method puntosFaranduleros(unPanelista) = tematicas.sum{tematica => tematica.puntosFaranduleros(unPanelista)}
}