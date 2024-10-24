import Nave.*
object troll {
  method voto() = nave.jugadorNoSospechoso()
}

object materialista {
  method voto() = nave.jugadorSinItems()
}

object detective {
  method voto() = nave.jugadorMasSospechoso()
}