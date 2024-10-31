import Personas.*
import Viviendas.*

object voluntario {
    method tiempoViviendaGeneral(_formulario) = 5

    method tiempoFormularioReducido(_formulario) = 2

    method tiempoFormularioExtendido(_formulario) = 4
}
    
class DocenteUniversitario {
    method tiempoViviendaGeneral(_formulario) = 7

    method tiempoFormularioReducido(_formulario) = 3

    method tiempoFormularioExtendido(_formulario) = 3
}

object docenteSistemas inherits DocenteUniversitario {
    override method tiempoViviendaGeneral(formulario) = if (formulario.tieneArtefacto(computadora)) 10 else super(formulario)
}

object docenteAntropolgia inherits DocenteUniversitario {
    override method tiempoFormularioReducido(formulario) = if (formulario.esDescendenteDe(puebloOriginario) || formulario.esDescendenteDe(afroamericano)) 5 else super(formulario)

    override method tiempoFormularioExtendido(formulario) = if (formulario.esDescendenteDe(puebloOriginario) || formulario.esDescendenteDe(afroamericano)) 5 else super(formulario)
}