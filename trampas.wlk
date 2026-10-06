import movimientos.*
import personaje.*
import wollok.game.*

object pozo{
    var property position = game.at(7,5)
    method image () = "trampa.png"

    method teAbsorbe(pozo, personaje) {
        if (pozo == personaje) {
        personaje.position(game.origin())
        }
    }

}