import personaje.*
import movimientos.*
import pociones.*
import enemigos.*
import trampas.*
import wollok.game.*

object config {

    method configurarJuego() {
        game.title("Grupo: PdePoder | La Llave")
        self.configurarDimensiones()
        gestorNiveles.iniciarNivelActual()  
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

    // Intenta generar una poción cada 5 segundos respetando el límite máximo de 4
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

    method configurarMovimientoSerpiente(serpiente) {
        game.onTick(350, "moverSerpiente", {
            serpiente.movete()
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

    method configurarTomarLlave() {
        game.onCollideDo(llave, { alguien =>
            alguien.vida(100)
            game.say(alguien, "¡La tengo!")
            gestorNiveles.completarNivel()
        })
    }

    method reiniciar() {
        gestorNiveles.iniciarNivelActual()
    }
}

// ================= NIVELES =================

object nivel1 {
    const enemigosComunes = [fantasma1, escorpion1]

    method iniciar() {    
        generadorPociones.reiniciar()
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes)
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)
        
        // Interfaz visual (HUD)
        game.addVisual(iconoVida)
        game.addVisual(contadorVida)

        enemigosComunes.forEach({ enemigo => game.addVisual(enemigo) })
    }

    method completar() { gestorNiveles.siguienteNivel() } 
}

object nivel2 {
    const enemigosComunes = [fantasma1, escorpion1]

    method iniciar() {  
        generadorPociones.reiniciar()
        serpiente1.position(game.at(13, 8))
        
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes)
        config.configurarMovimientoSerpiente(serpiente1)
        config.configurarCaerEnTrampa()
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje, "¡Entraste al nivel 2!")
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)
        game.addVisual(pozo)

        // Interfaz visual (HUD)
        game.addVisual(iconoVida)
        game.addVisual(contadorVida)
        
        enemigosComunes.forEach({ enemigo => game.addVisual(enemigo) })
        game.addVisual(serpiente1)
    }

    method completar() { gestorNiveles.siguienteNivel() }  
}

object nivel3 {
    const enemigosComunes = [fantasma1, escorpion1]

    method iniciar() {  
        generadorPociones.reiniciar()
        serpiente1.position(game.at(13, 8))

        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes)
        config.configurarMovimientoSerpiente(serpiente1)
        config.configurarCaerEnTrampa()
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje, "¡Entraste al nivel 3!")
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)
        game.addVisual(pozo)

        // Interfaz visual (HUD)
        game.addVisual(iconoVida)
        game.addVisual(contadorVida)
        
        enemigosComunes.forEach({ enemigo => game.addVisual(enemigo) })
        game.addVisual(serpiente1)
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

object gestorNiveles {
    var nivelActual = 0
    const niveles = [nivel1, nivel2, nivel3]

    method iniciarNivelActual() {
        game.clear()
        personaje.reiniciar()
        generadorPociones.reiniciar()
        niveles.get(nivelActual).iniciar()
    }

    method finDelJuego() {
        game.clear()
        game.addVisual(finAnimacion)
        game.onTick(200, "animarFin", { finAnimacion.animar() })
        game.say(finAnimacion, "¡Completaste el juego! Presioná R para reiniciar")
        keyboard.r().onPressDo({
            nivelActual = 0
            self.iniciarNivelActual()
        })
    }

    method completarNivel() { niveles.get(nivelActual).completar() }

    method siguienteNivel() {
        nivelActual += 1
        self.iniciarNivelActual()
    }
}