class Enfermedad {
    
    method celulasAmenazadas(personaEnferma) {
        return tipoEnfermedad.
    }
}

class Persona {
    var temperatura
    var celulas
    var enfermedades

    method contraerEnfermedad(enfermedad) {
        enfermedades.add(enfermedad)
    }

    method vivirDias(dias) {
        enfermedades.map({enfermedad => enfermedad.causarEfecto(self)})
    }   
}