import Nave.*
object reducirOxigeno {
  method realizate() {
    if (!nave.alguienTieneTuboDeOxigeno()) {
      nave.reducirOxigeno(10)
    }
  }
}

class ImpugnarJugador {
  const jugadorImpugnado

  method realizate() {
    jugadorImpugnado.impugnarVoto()
  }
}