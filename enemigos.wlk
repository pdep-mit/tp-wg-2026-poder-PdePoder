import movimientos.*
import personaje.*
import wollok.game.*

object fantasma{
    var property position = game.at(2,1)
    method image () = "ghost.png"
    

    var direccion = haciaArriba

    method mover() {
        movimiento.mover(self, direccion)

        if(position.y() == 6) direccion = haciaAbajo
        if(position.y() == 0) direccion = haciaArriba
    }

    method teAtrapa(alguien, personaje) {
    if (alguien == personaje) {
       personaje.position(game.origin())
    }
    }
}

class Serpiente{
    var property position = game.at(12,8)
    method image () = "snakee.png"
}
const serpiente1 = new Serpiente()
class Escorpion{
    var property position = game.at(11,1)
    method image () = "scorpion.png"
}
const escorpion1 = new Escorpion()