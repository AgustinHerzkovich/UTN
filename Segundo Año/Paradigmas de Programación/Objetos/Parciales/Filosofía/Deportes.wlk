object futbol {
    method diasDeRejuvenecimiento() = 1
}

class Polo {
    method diasDeRejuvenecimiento() = 2
}

object waterpolo inherits Polo {
    override method diasDeRejuvenecimiento() = super() * 2
}