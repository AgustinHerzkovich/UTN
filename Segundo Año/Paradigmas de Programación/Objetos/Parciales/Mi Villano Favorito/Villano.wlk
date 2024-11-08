import Arma.*
import Minions.*

class Villano {
    const minions = []
    const ciudad

    method nuevoMinion() {
        minions.add(new Minion(bananas = 5, armas = [new Arma(nombre = "rayoCongelante", potencia = 10)]))
    }

    method planificarMaldad(unaMaldad) {
        unaMaldad.asignarMinions(self.minionsCapacitadosPara(unaMaldad))
    }

    method minionsCapacitadosPara(unaMaldad) = minions.filter{minion => unaMaldad.estaCapacitado(minion)}

    method realizarMaldad(unaMaldad) {
        unaMaldad.serRealizadaEn(ciudad)
    }

    method minionMasUtil() = minions.max{minion => minion.cantidadMaldadesRealizadas()}

    method minionsInutiles() = minions.filter{minion => minion.noParticipoEnNingunaMaldad()}
}