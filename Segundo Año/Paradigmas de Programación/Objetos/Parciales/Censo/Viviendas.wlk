class Vivienda {
    const property cantidadHabitantes 
    const property estiloConstruccion
    
    method estaHacinada()
}

class ViviendaParticular inherits Vivienda{
    const artefactos = []
    const property cantidadAmbientes

    method tieneArtefacto(unArtefacto) = artefactos.contains(unArtefacto)

    override method estaHacinada() = cantidadHabitantes >= 2 * cantidadAmbientes

    method tiempoCensado(censista) = censista.tiempoViviendaGeneral()
}

class ViviendaColectiva inherits Vivienda{
    const property superficie
    const property tipo
    
    override method estaHacinada() = superficie / cantidadHabitantes <  10 

    method tiempoCensado(_censista) = 10
}

// Estilos de construcción
object material{}

object chapa{}

object madera{}

// Artefactos
object heladera{}

object computadora{}

object celular{}

//tipo vivienda colectiva

object geriatrico{}

object hotel{}

object carcel{}

object convento{}