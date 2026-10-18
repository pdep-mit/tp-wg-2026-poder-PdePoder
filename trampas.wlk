import movimientos.*
import personaje.*
import wollok.game.*

object pozo {
    var property position = game.at(7, 5)
    method image() = "trampa.png"

    method teAbsorbe(personaje) {
        personaje.position(game.origin())
    }

    method teAtaca(personaje) {
        self.teAbsorbe(personaje)
    }
}

object trampaOso {
    var property position = game.at(4, 3) // Posición inicial en el mapa
    method image() = "trampaOso.png" // Asset de la trampa para osos

    method teAtaca(personaje) {
        personaje.recibirDanio(90)
        game.say(personaje, "¡Caí en una trampa de oso! (-90 vida)")
    }
}