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

        keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
        keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
        keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})
    }

    method position() = game.origin()

    method image() = "menuPv21.png"
}

object controlDeVolumen {
    var estaMuteado = false
    const musicaPrincipal = config.music()
    var volumen = 0.2
    method volumen(){
        return volumen
    }
    method intercambiarMuteado(){
        estaMuteado = not estaMuteado
        if(estaMuteado){
            musicaPrincipal.volume(0)
        }
        else{
            musicaPrincipal.volume(volumen)
        }
    } 
    method aumentarVolumen(){
        if (not estaMuteado){
            volumen = (volumen + 0.1).min(1)
            musicaPrincipal.volume(volumen)
        }
    }
    method bajarVolumen(){
        if (not estaMuteado){
            volumen = (volumen - 0.1).max(0.1)
            musicaPrincipal.volume(volumen)
        }
    }
}