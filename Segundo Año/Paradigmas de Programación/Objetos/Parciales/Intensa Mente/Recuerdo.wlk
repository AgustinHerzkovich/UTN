class Recuerdo {
    const descripcion
    const fecha
    const property emocion

    method asentarse(persona) {
        emocion.asentarse(self, persona)
    }

    method esDificilDeExplicar() = descripcion.words().size() > 10

    method esAlegre() = emocion.esAlegre()

    method contiene(palabra) = descripcion.contains(palabra)

    method tieneEmocionDominante(emocionDominante) = emocion == emocionDominante

    method esMasAntiguoQue(edad) = self.antiguedad() > edad

    method antiguedad() = new Date().year() - fecha.year()
}
