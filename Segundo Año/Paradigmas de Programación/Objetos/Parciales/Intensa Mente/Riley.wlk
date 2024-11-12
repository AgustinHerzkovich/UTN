import Recuerdo.*
import Emociones.*

object riley {
    var nivelFelicidad = 1000
    var emocionDominante = alegria
    const recuerdos = []
    const pensamientosCentrales = []
    const procesosMentales = []
    const memoriaLargoPlazo = []
    const edad = 11
    var pensamientoActual = null

    method cambiarEmocionDominante(nuevaEmocion) {
        emocionDominante = nuevaEmocion
    }

    method vivirEvento(unaDescripcion) {
        recuerdos.add(new Recuerdo(descripcion = unaDescripcion, fecha = new Date(), emocion = emocionDominante))
    }

    method asentar(recuerdo) {
        recuerdo.asentarse(self)
    }

    method agregarPensamientoCentral(recuerdo) {
        pensamientosCentrales.add(recuerdo)
    }

    method nivelFelicidad() = nivelFelicidad

    method disminuirFelicidad(porcentaje) {
        nivelFelicidad *= 1 - porcentaje/100
        self.prevenirDepresion()
    }

    method prevenirDepresion() {
        if (nivelFelicidad < 1) {
            throw new DomainException(message = "Nivel de felicidad muy bajo")
        }
    }

    method recuerdosRecientes() = recuerdos.take(5)

    method pensamientosCentralesDificilesDeExplicar() = pensamientosCentrales.filter{pensamiento => pensamiento.esDificilDeExplicar()}

    method niega(recuerdo) = emocionDominante.niega(recuerdo)

    method dormir() {
        procesosMentales.forEach{proceso => proceso.desencadenar(self)}
    }

    method asentarTodosLosRecuerdosDelDia() {
        recuerdos.forEach{recuerdo => recuerdo.asentarse(self)}
    }

    method asentarRecuerdosClaves(palabraClave) {
        self.recuerdosClaves(palabraClave).forEach{recuerdo => recuerdo.asentarse(self)}
    }

    method recuerdosClaves(palabraClave) = recuerdos.filter{recuerdo => recuerdo.contiene(palabraClave)} 

    method enviarAMemoriaLargoPlazoRecuerdosNoCentrales() {
        memoriaLargoPlazo.add(self.recuerdosNoCentralesYNoNegados())
    }

    method recuerdosNoCentralesYNoNegados() = recuerdos.filter{recuerdo => ! recuerdo.esCentral() and ! self.niega(recuerdo)}

    method esCentral(recuerdo) = pensamientosCentrales.contains(recuerdo)

    method algunPensamientoCentralEnLargoPlazo() = pensamientosCentrales.any{pensamiento => memoriaLargoPlazo.contains(pensamiento)}

    method todosLosRecuerdosConMismaEmocion() {
        const emocion = recuerdos.anyOne().emocion()
        return recuerdos.all{recuerdo => recuerdo.tieneEmocionDominante(emocion)}
    }

    method producirDesequilibrioHormonal() {
        self.disminuirFelicidad(15)
        self.perderTresPensamientosCentralesMasAntiguos()
    }

    method perderTresPensamientosCentralesMasAntiguos() = pensamientosCentrales.reverse().drop(3).reverse()

    method restaurarFelicidad(cantidad) {
        nivelFelicidad += 1000.min(nivelFelicidad + cantidad)
    }

    method liberarRecuerdosDelDia() {
        recuerdos.clear()
    }

    method rememorar() {
        pensamientoActual = memoriaLargoPlazo.any{recuerdo => recuerdo.esMasAntiguoQue(edad / 2)}
    }

    method repeticionesLargoPlazo(recuerdo) = memoriaLargoPlazo.occurrencesOf(recuerdo)

    method esRepetidoEnLargoPlazo(recuerdo) = self.repeticionesLargoPlazo(recuerdo) > 1

    method estaTeniendoUnDejaVu() = self.esRepetidoEnLargoPlazo(pensamientoActual)
}