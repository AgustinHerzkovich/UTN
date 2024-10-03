// JefeDeDepartamento.wlk
import Persona.*
import Medico.*

class JefeDeDepartamento inherits Medico(dosis = 0) {
  const subordinados = #{}

  override method atenderA(unaPersona) {
    subordinados.anyOne().atenderA(unaPersona)
  }

  method agregarSubordinado(unSubordinado) {
    subordinados.add(unSubordinado)
  }
}