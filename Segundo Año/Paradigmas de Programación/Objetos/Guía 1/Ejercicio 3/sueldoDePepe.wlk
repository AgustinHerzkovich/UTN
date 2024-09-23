object pepe {
  var categoria = cadete
  var cantidadFaltas = 0 
  var bonoResultados = fijo

  method sueldo() {
    return self.sueldoNeto() + self.bonoPresentismo() + self.bonoResultados()
  }
  
  method sueldoNeto() = categoria.sueldo()
  
  method bonoPresentismo() = bonoPresentismo.bono(cantidadFaltas)
  
  method bonoResultados() = bonoResultados.bono(self)

}

object gerente {
  method sueldo() = 1000
}

object cadete {
  method sueldo() = 1500
}

object bonoPresentismo {
  method bono(cantidadFaltas) {
    if (cantidadFaltas == 0) {
      return 100
    } else {
      if (cantidadFaltas == 1) {
        return 50
      } else {
        return 0
      }
    }
  }
}

object nioqui {
  method bono(empleado) {
    return empleado.sueldoNeto() * 0.1
  }
}

object fijo {
  method bono(_empleado) {
    return 80
  }
}

object nada {
  method bono(_empleado) {
    return 0
  }
}