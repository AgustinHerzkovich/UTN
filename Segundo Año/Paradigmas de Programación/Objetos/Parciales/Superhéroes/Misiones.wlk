class Mision {
    const property objetivo

    method danio() = objetivo.danio()

    method seraExitosa()
}

class Coercitiva inherits Mision {
    const nivelMinimoSoborno

    override method seraExitosa() = objetivo.esExtorsionable() || objetivo.inclinacionAlSobornoMayorA(nivelMinimoSoborno)
}

class Destructiva inherits Mision {
    override method seraExitosa() = true
}