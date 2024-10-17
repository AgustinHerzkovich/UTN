// sangre/sangre.wlk
class Sangre {
    const property grupo
    const property factor

    method compatibleCon(otraSangre) = grupo.puedeDonarleA(otraSangre.grupo()) and factor.puedeDonarleA(otraSangre.factor())
}

// Grupos
object o {
    method puedeDonarleA(otroGrupo) = true
}

object a {
    method puedeDonarleA(otroGrupo) = [self, ab].contains(otroGrupo)
}

object b {
    method puedeDonarleA(otroGrupo) = [self, ab].contains(otroGrupo)
}

object ab {
    method puedeDonarleA(otroGrupo) = otroGrupo == self
}

object r {
    method puedeDonarleA(_otroGrupo) = false
}

// Factores
object negativo {
    method puedeDonarleA(otroFactor) = true
}

object positivo {
    method puedeDonarleA(otroFactor) = otroFactor == self
}