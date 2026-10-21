import wollok.game.*
import gameConfiguration.*

object menuInicio {

    method iniciar() {
        game.clear()

        game.addVisual(self)

        keyboard.enter().onPressDo({
            game.removeVisual(self)
            gestorNiveles.iniciarNivelActual()
        })

        keyboard.i().onPressDo({
            game.say(self, "Usa las flechas para moverte. Evita enemigos y trampas. Busca la llave para avanzar.")
        })
    }

    method position() = game.origin()

    method image() = "menuP.png"
}
