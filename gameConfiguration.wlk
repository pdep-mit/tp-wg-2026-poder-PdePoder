import personaje.*
import movimientos.*
import pociones.*
import enemigos.*
import trampas.*
import wollok.game.*

object config {

    method configurarJuego() {
        game.title("Grupo: PdePoder | La Llave")
        //self.configurarDimensiones()
        //gestorNiveles.iniciarNivelActual()  
        self.configuracionMenu()
        self.mostrarMenu()
    }

    method configuracionMenu(){
        game.height(10)
        game.width(15)
    }
    method mostrarMenu() {
        game.clear()
        game.addVisual(menu)

        keyboard.i().onPressDo({ self.mostrarInstrucciones() })

        keyboard.enter().onPressDo({ gestorNiveles.mostrarPresentacionNivel() })
    }

    method mostrarInstrucciones() {
        game.clear()
        game.addVisual(instrucciones)
        keyboard.v().onPressDo({ self.mostrarMenu() })
    }

    method configurarDimensiones() {
        game.height(10)
        game.width(15)
        game.boardGround("fondo1015.png")
    }

    method configurarAcciones() {
        var personajeControlado = personaje

        keyboard.t().onPressDo({ personajeControlado = personaje })
        keyboard.up().onPressDo({ self.moverSiVive(personajeControlado, haciaArriba) })
        keyboard.down().onPressDo({ self.moverSiVive(personajeControlado, haciaAbajo) })
        keyboard.left().onPressDo({ self.moverSiVive(personajeControlado, haciaLaIzquierda) })
        keyboard.right().onPressDo({ self.moverSiVive(personajeControlado, haciaLaDerecha) })
        keyboard.r().onPressDo({ if (personaje.estaMuerto()) self.reiniciar() })
    }

    method moverSiVive(personajeLibre, direccion) {
        if (personajeLibre.estaVivo()) {
            movimiento.mover(personajeLibre, direccion)
        }
    }

    method configurarAparicionPociones() {
        game.onTick(5000, "aparecerPocion", {
            generadorPociones.intentarGenerarPocion()
        })
    }

    method configurarMovimientoEnemigos(enemigos) {
        game.onTick(400, "moverEnemigos", {
            enemigos.forEach({ enemigo => enemigo.movete() })
        })
    }

    method configurarMovimientoSerpientes(serpientes) {
        game.onTick(350, "moverSerpiente", {
            serpientes.forEach({ serpiente => serpiente.movete() })
        })
    }

    method configurarColisiones() {
        game.onCollideDo(personaje, { elemento =>
            elemento.teAtaca(personaje)
        })
    }

    method configurarCaerEnTrampa() {
        game.onCollideDo(pozo, { alguien =>
            pozo.teAbsorbe(alguien)
        })
    }

    //method configurarTomarLlave() {
    //    game.onCollideDo(llave, { alguien =>
    //        alguien.agarrarLaLlave()
    //    })
    //}

    method reiniciar() {
        gestorNiveles.iniciarNivelActual()
    }
}

// ================= NIVELES REDISEÑADOS =================

object nivel1 {
    const enemigosComunes = [fantasma1, fantasma2, escorpion1]
    const trampas = [trampaOso1]

    method iniciar() {    
        generadorPociones.reiniciar()
        
        // Posiciones iniciales
        fantasma1.position(game.at(3, 1))
        fantasma2.position(game.at(10, 1))
        escorpion1.position(game.at(10, 4))

        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes)
        //config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje,"¡Nivel 1: Evitá las trampas y enemigos!")
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)
        
        // HUD
        game.addVisual(iconoVida)
        game.addVisual(contadorVida)

        trampas.forEach({ trampa => game.addVisual(trampa) })
        enemigosComunes.forEach({ enemigo => game.addVisual(enemigo) })
    }

    method completar() { gestorNiveles.siguienteNivel() } 
}

object nivel2 {
    const enemigosComunes = [fantasma1, escorpion1, escorpion2]
    const serpientes = [serpiente1]
    const trampas = [pozo, trampaOso1]

    method iniciar() {  
        generadorPociones.reiniciar()

        // Reset de posiciones
        fantasma1.position(game.at(5, 1))
        escorpion1.position(game.at(10, 3))
        escorpion2.position(game.at(2, 7))
        serpiente1.position(game.at(13, 8))
        
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes)
        config.configurarMovimientoSerpientes(serpientes)
        config.configurarCaerEnTrampa()
        //config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje,"¡Nivel 2: Cuidado con la serpiente!")
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)

        // HUD
        game.addVisual(iconoVida)
        game.addVisual(contadorVida)

        trampas.forEach({ trampa => game.addVisual(trampa) })
        enemigosComunes.forEach({ enemigo => game.addVisual(enemigo) })
        serpientes.forEach({ serpiente => game.addVisual(serpiente) })
    }

    method completar() { gestorNiveles.siguienteNivel() }  
}

object nivel3 {
    const enemigosComunes = [fantasma1, fantasma2, escorpion1, escorpion2]
    const serpientes = [serpiente1, serpiente2]
    const trampas = [pozo, trampaOso1, trampaOso2]

    method iniciar() {  
        generadorPociones.reiniciar()

        // Reset de posiciones extremas
        fantasma1.position(game.at(4, 1))
        fantasma2.position(game.at(8, 1))
        escorpion1.position(game.at(12, 2))
        escorpion2.position(game.at(2, 6))
        serpiente1.position(game.at(13, 8))
        serpiente2.position(game.at(1, 8))

        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes)
        config.configurarMovimientoSerpientes(serpientes)
        config.configurarCaerEnTrampa()
        //config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje,"¡Nivel Final: Desafío Extremo!")
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)

        // HUD
        game.addVisual(iconoVida)
        game.addVisual(contadorVida)

        trampas.forEach({ trampa => game.addVisual(trampa) })
        enemigosComunes.forEach({ enemigo => game.addVisual(enemigo) })
        serpientes.forEach({ serpiente => game.addVisual(serpiente) })
    }

    method completar() { gestorNiveles.finDelJuego() }  
}

// ================= GESTOR DE NIVELES Y ANIMACIÓN =================

object finAnimacion {
    var frame = 0
    const frames = ["F1.png", "F2.png", "F3.png", "F4.png", "F5.png", "F6.png", "F7.png", "F8.png", "F9.png", "F10.png", "F11.png", "F12.png", "F13.png", "F14.png", "F15.png", "F16.png", "F17.png", "F18.png"]
   
    method position() = game.origin()
    method image() = frames.get(frame)
    method animar() { frame = (frame + 1) % frames.size() }
}

object menu {
    method position() = game.origin()
    method image() = "menuP.png"
}

object instrucciones {
    method position() = game.origin()
    //method image() = "instrucciones.png"
}
object presentacionNivel1 {
    method position() = game.origin()
    method image() = "pNivel1.png"
}

object presentacionNivel2 {
    method position() = game.origin()
    method image() = "pNivel2.png"
}

object presentacionNivel3 {
    method position() = game.origin()
    method image() = "pNivel3.png"
}
object gestorNiveles {
    var nivelActual = 0
    const niveles = [nivel1, nivel2, nivel3]
    const presentaciones = [presentacionNivel1, presentacionNivel2, presentacionNivel3]
    method iniciarNivelActual() {
        game.clear()
        config.configurarDimensiones()
        personaje.reiniciar()
        generadorPociones.reiniciar()
        niveles.get(nivelActual).iniciar()
    }

    method mostrarPresentacionNivel() {
        game.clear()
        config.configuracionMenu()
        game.addVisual(presentaciones.get(nivelActual))
        keyboard.enter().onPressDo({ self.iniciarNivelActual() })
    }

    method finDelJuego() {
        game.clear()
        game.addVisual(finAnimacion)
        game.onTick(200, "animarFin", { finAnimacion.animar() })
        game.say(finAnimacion, "¡Completaste el juego! Presioná R para reiniciar")
        keyboard.r().onPressDo({
            nivelActual = 0
            self.mostrarPresentacionNivel()
        })
    }

    method completarNivel() { niveles.get(nivelActual).completar() }

    method siguienteNivel() {
        nivelActual += 1
        self.mostrarPresentacionNivel()
    }
}