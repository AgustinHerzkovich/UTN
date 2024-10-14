class Vaca {
    var peso
    var sed = false
    var vacunada = false

    method comer(gramos) {
        peso += gramos / 3
        sed = true
    }

    method beber() {
        sed = false
        peso -= 500
    }

    method vacunar() {
        vacunada = true
    }

    method convieneVacunar() = !vacunada

    method tieneHambre() = peso < 200000
    
    method caminar() {
        peso -= 3000
    }

    method tieneSed() = sed

    method peso() = peso
}

class Cerdo {
    var peso
    var hambre = false
    var sed = false
    var cantidadComidas = 0
    const comidas = []

    method comer(gramos) {
        peso += 0.max(gramos - 200)

        comidas.add(gramos)
        cantidadComidas += 1

        if (cantidadComidas > 3) {
            sed = true
        }

        if (gramos > 1000) {
            hambre = false
        }
    }

    method maximaComida() = comidas.max()

    method convieneVacunar() = true

    method beber() {
        sed = false
        hambre = true
        cantidadComidas = 0
    }

    method tieneHambre() = hambre

    method tieneSed() = sed

    method peso() = peso
}

class Gallina {
    const peso = 4000
    var cantidadComidas = 0

    method comer() {
        cantidadComidas += 1
    }

    method tieneHambre() = true

    method tieneSed() = false

    method convieneVacunar() = false

    method vecesQueComio() = cantidadComidas

    method peso() = peso
}