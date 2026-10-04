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