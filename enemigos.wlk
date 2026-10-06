import movimientos.*
import personaje.*
import wollok.game.*

object fantasma{
    var property position = game.at(2,1)
    method image () = "ghost.png"
    var direccion = haciaArriba

    method movete() {
        movimiento.mover(self, direccion)

        if(position.y() == 6) direccion = haciaAbajo
        if(position.y() == 0) direccion = haciaArriba
    }

    method teAtaca(alguien) {
        alguien.recibirDanio(15)
        game.say(alguien, "Me descontaron 15 de vida")
    }
}

class Serpiente{
    var property position = game.center()
    method image () = "snakee.png"

    method movete(){
        movimientoRandom.mover(self)
    }
}
const serpiente1 = new Serpiente()
class Escorpion{
    var property position = game.at(10,4)
    method image () = "scorpion.png"
}
const escorpion1 = new Escorpion()