class Vaca {
    var peso
    var tieneSed = false

    method comer(gramos) {
        peso += gramos / 3
        tieneSed = true
    }

    method beber() {
        tieneSed = false
        peso -= 500
    }

    
}