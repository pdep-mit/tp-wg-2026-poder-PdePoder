import movimientos.*
import personaje.*
import wollok.game.*

class Pozo {
    var property position = game.at(7, 5)
    method image() = "trampa.png"

    method teAbsorbe(personaje) {
        personaje.position(game.origin())
    }

    method teAtaca(personaje) {
        self.teAbsorbe(personaje)
    }
}

class TrampaOso {
    var property position = game.at(4, 3)
    method image() = "trampaOso.png"

    method teAtaca(personaje) {
        personaje.recibirDanio(90)
        game.say(personaje, "¡Caí en una trampa de oso! (-90 vida)")
    }
}