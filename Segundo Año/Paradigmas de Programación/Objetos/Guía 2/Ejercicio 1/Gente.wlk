class Apurado {
    method aceptaSubirse(_micro) = true
}

class Claustrofobico {
    method aceptaSubirse(micro) = micro.volumenMayorA120()
}

class Fiaca {
    method aceptaSubirse(micro) = micro.tieneEspacioEnElPiso()
}

class Moderado {
    const lugaresMinimos

    method aceptaSubirse(micro) = micro.quedanLugares(lugaresMinimos)
}

class Obsecuente {
    const jefe

    method aceptaSubirse(micro) = jefe.aceptaSubirse(micro)
}