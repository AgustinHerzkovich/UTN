// Dr_Casa_Temporada_1.wlk
class Persona {
    var temperatura
    var celulas
    var celulasAfectadasAgresivas = 0
    var enfermedades = []
    var diasAfectadoPorEnfermedad = new Dictionary()

    method contraerEnfermedad(enfermedad) {
        enfermedades.add(enfermedad)
        diasAfectadoPorEnfermedad.put(enfermedad, 0)
    }

    method vivirUnDia() {
        enfermedades.forEach({enfermedad => self.aplicarEnfermedad(enfermedad)})
    }

    method aplicarEnfermedad(enfermedad) {
        diasAfectadoPorEnfermedad.put(enfermedad, diasAfectadoPorEnfermedad.get(enfermedad) + 1)
        enfermedad.causarEfecto(self)
    }

    method vivirDias(dias) {
        dias.times{_self => self.vivirUnDia()}
    }   

    method aumentarTemperatura(grados) {
        temperatura = math.min(temperatura + grados, 45)
    }

    method estaEnComa() {
        return temperatura == 45 || celulas < 1000000
    }

    method destruirCelulas(celulasAmenazadas) {
        celulas -= celulasAmenazadas
    }

    method tieneEnfermdad(enfermedad) {
        return enfermedades.contains(enfermedad)
    }

    method celulas() = celulas // Getter

    method celulasAfectadasAgresivas() = celulasAfectadasAgresivas // Getter

    method celulasAfectadasAgresivas(celulasAfectadas) { // Setter
        celulasAfectadasAgresivas += celulasAfectadas 
    }

    method diasAfectado(enfermedad) {
        return diasAfectadoPorEnfermedad.get(enfermedad)
    }

    method enfermedadQueMasAfecta() {
        return enfermedades.max({enfermedad => enfermedad.celulasAmenazadas()})
    }
}

class Infecciosa {
    var celulasAmenazadas

    method causarEfecto(persona) {
        persona.aumentarTemperatura(celulasAmenazadas / 1000)
        
        if(self.esAgresiva(persona)) {
            persona.celulasAfectadasAgresivas(celulasAmenazadas)
        }   
    }

    method reproducirse() {
        celulasAmenazadas *= 2
    }

    method esAgresiva(persona) {
        return celulasAmenazadas > persona.celulas() * 0.1
    }

    method celulasAmenazadas() = celulasAmenazadas // Getter
}

class Autoinmune {
    var celulasAmenazadas

    method causarEfecto(persona) {
      persona.destruirCelulas(celulasAmenazadas)

      if(self.esAgresiva(persona)) {
        persona.celulasAfectadasAgresivas(celulasAmenazadas)
      }
    }

    method esAgresiva(persona) {
        return persona.diasAfectado(self) > 30
    }

    method celulasAmenazadas() = celulasAmenazadas // Getter
}

object math {
    method min(a, b) {
        if (a < b) {
            return a
        } else {
            return b
        }
    }
}