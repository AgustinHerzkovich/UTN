// Islas.wlk
import Pajaros.*
import Obstaculos.*
object islaPajaro {
    const property pajaros = #{red, terence}
    const property pajarosHomenajeados = #{terence}

    method pajarosFuertes() = pajaros.filter{pajaro => pajaro.esFuerte()}

    method fuerza() = self.pajarosFuertes().sum{pajaro => pajaro.fuerza()}

    method atacarIslaCerdito() {
        pajaros.forEach{pajaro => pajaro.atacar(islaCerdito)}
    }
}

object islaCerdito {
    const property obstaculos = [new Pared(ancho = 2, material = vidrio), new Pared(ancho = 3, material = madera)]

    method derribado(obstaculo) {
        obstaculos.remove(obstaculo)
    }

    method libreDeObstaculos() = obstaculos.isEmpty()
}
