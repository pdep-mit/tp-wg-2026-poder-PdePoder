import wollok.game.*

object personaje {
    var property vida = 100
    var property energia = 50
    var property position = game.origin()

    method image() = "lionel10.png"

    method recibirDanio(cantidad) {
        vida -= cantidad 
    }

    method curar(cantidad) {
        vida += cantidad
    }

    method sumarEnergia(cantidad) {
        energia += cantidad
    }
}

object llave{
  var property position = game.at(14,8)
  method image() = "llave.png"

}