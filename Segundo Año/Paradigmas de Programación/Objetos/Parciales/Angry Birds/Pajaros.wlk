// Pajaros.wlk
class Pajaro {
    var ira
    method enojarse() {
        ira *= 2
    }
    
    method fuerza()

    method esFuerte() = self.fuerza() > 50

    method tranquilizarse(){
        ira-=5
    }

    method puedeDerribar(obstaculo) = self.fuerza() > obstaculo.resistencia()

    method atacar(isla) {
        self.derribar(isla, isla.obstaculos().first())
    }

    method derribar(isla, obstaculo) {
        if(self.puedeDerribar(obstaculo)) {
            isla.derribado(obstaculo)
        }
    }
}

/*
Para crear nuevos pájaros, simplemente se instancia la clase Pájaro, y si se quiere que tenga algún
comportamiento diferente, se crea una subclase que herede de Pájaro y se redefine el método que se quiera modificar.
Nos ayudan los conceptos de polimorfismo y herencia.
*/

class Comun inherits Pajaro {
    override method fuerza() = ira * 2
}

class Rencoroso inherits Pajaro{
    var cantidadEnojos = 1
    var multiplicador
    
    override method fuerza()= ira * multiplicador * cantidadEnojos

    override method enojarse(){
        super()
        cantidadEnojos += 1
    }

    method modificarMultiplicador(nuevoMultiplicador){
        multiplicador = nuevoMultiplicador
    }
}

const red = new Rencoroso(ira = 1, multiplicador = 10)

class Bomb inherits Comun {
    var topeFuerza = 9000

    override method fuerza() {
        return self.validacionFuerza(super())
    }
    
    method validacionFuerza(fuerzaOriginal) {
        if(fuerzaOriginal > topeFuerza) {
            return topeFuerza
        } else {
            return fuerzaOriginal
        }
    }

    method modificarTopeFuerza(nuevoTope) {
        topeFuerza = nuevoTope
    }
}

class Chuck inherits Pajaro{
    var velocidad
    
    override method fuerza(){ 
        if (velocidad>80){
            return 150 + 5 *(velocidad - 80)
        }else{
            return 150
        }
    }

    override method enojarse(){
        velocidad *= 2
    }

    override method tranquilizarse() {
        // No tiene efecto
    }
}

const terence = new Rencoroso(ira = 10, multiplicador = 10)

class Matilda inherits Comun{
    const huevos = []
    
    override method fuerza() = super() + huevos.sum{huevo => huevo.fuerza()}

    override method enojarse(){
        self.ponerHuevo(2000)        
    }
    
   method ponerHuevo(peso){
    huevos.add(new Huevo(peso = peso))
   }
        
}  

class Huevo {
    const peso

    method fuerza() = peso
}












































