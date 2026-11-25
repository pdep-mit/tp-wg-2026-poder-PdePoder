import personaje.*
import movimientos.*
import pociones.*
import enemigos.*
import trampas.*
import menu.*
import wollok.game.*

object config {

    method configurarJuego() {
        game.title("Grupo: PdePoder | La Llave")
        self.configurarDimensiones()
        self.reproduccionMusica()
        
        menuInicio.iniciar()
    }

    const music = game.sound("sonidoJuego.mp3")
    method music(){return music}
    method reproduccionMusica(){
        music.shouldLoop(true)
        music.volume(controlDeVolumen.volumen())
        music.play()
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

    method configurarMovimientoEnemigos(enemigos, intervaloMs) {
        game.onTick(intervaloMs, "moverEnemigos", {
            enemigos.forEach({ enemigo => enemigo.movete() })
        })
    }

    method configurarMovimientoSerpientes(serpientes, intervaloMs) {
        game.onTick(intervaloMs, "moverSerpiente", {
            serpientes.forEach({ serpiente => serpiente.movete() })
        })
    }

    method configurarColisiones() {
        game.onCollideDo(personaje, { elemento =>
            elemento.teAtaca(personaje)
        })
    }

    method configurarCaerEnTrampa() {
        const pozo = new Pozo()
        game.onCollideDo(pozo, { alguien =>
            pozo.teAbsorbe(alguien)
        })
    }

    method configurarTomarLlave() {
        game.onCollideDo(llave, { alguien =>
            llave.teAtaca(alguien)
        })
    }

    method reiniciar() {
        gestorNiveles.reiniciarAlNivelUno()
    }
}

// ================= NIVELES =================

object nivel1 {
    var enemigosComunes = []
    var serpientes = []
    var trampas = []

    method iniciar() {    
        generadorPociones.reiniciar()
        llave.position(game.at(14, 8))
        
        enemigosComunes = [
            new Fantasma(position = game.at(3, 1)),
            new Fantasma(position = game.at(7, 8)),
            new Fantasma(position = game.at(11, 2)),
            new Escorpion(position = game.at(10, 4)),
            new Escorpion(position = game.at(4, 7))
        ]
        serpientes = [
            new Serpiente(position = game.at(12, 7))
        ]
        trampas = [
            new TrampaOso(position = game.at(6, 3)),
            new TrampaOso(position = game.at(12, 5))
        ]

        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes, 330)
        config.configurarMovimientoSerpientes(serpientes, 360)
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje, "¡Nivel 1: Evitá las trampas y enemigos!")
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

object nivel2 {
    var enemigosComunes = []
    var serpientes = []
    var trampas = []

    method iniciar() {  
        generadorPociones.reiniciar()
        llave.position(game.at(14, 8))
       

        enemigosComunes = [
            new Fantasma(position = game.at(4, 1)),
            new Fantasma(position = game.at(8, 8)),
            new Fantasma(position = game.at(12, 3)),
            new Escorpion(position = game.at(10, 2)),
            new Escorpion(position = game.at(2, 5)),
            new Escorpion(position = game.at(13, 6))
        ]
        serpientes = [
            new Serpiente(position = game.at(9, 7)),
            new Serpiente(position = game.at(5, 7))
        ]
        trampas = [
            new Pozo(position = game.at(7,5)),
            new TrampaOso(position = game.at(5, 3)),
            new TrampaOso(position = game.at(11, 4))
        ]
        
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes, 240)
        config.configurarMovimientoSerpientes(serpientes, 210)
        config.configurarCaerEnTrampa()
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje, "¡Nivel 2: Más rápidos y peligrosos!")
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
    var enemigosComunes = []
    var serpientes = []
    var trampas = []

    var alturaLlave = 8
    var sentidoLlave = -1

    method iniciar() {  
        generadorPociones.reiniciar()
        alturaLlave = 8
        sentidoLlave = -1
        llave.position(game.at(14, alturaLlave))        
     

        enemigosComunes = [
            new Fantasma(position = game.at(3, 1)),
            new Fantasma(position = game.at(6, 8)),
            new Fantasma(position = game.at(9, 2)),
            new Fantasma(position = game.at(12, 7)),
            new Escorpion(position = game.at(14, 2)),
            new Escorpion(position = game.at(2, 5)),
            new Escorpion(position = game.at(11, 7))
        ]
        serpientes = [
            new Serpiente(position = game.at(9, 7)),
            new Serpiente(position = game.at(3, 7)),
            new Serpiente(position = game.at(10, 1))
        ]
        trampas = [
            new Pozo(position = game.at(8,4)),
            new TrampaOso(position = game.at(5, 2)),
            new TrampaOso(position = game.at(10, 6)),
            new TrampaOso(position = game.at(12, 3))
        ]

        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigosComunes, 200)
        config.configurarMovimientoSerpientes(serpientes, 185)
        config.configurarCaerEnTrampa()
        config.configurarTomarLlave()
        game.onTick(500, "moverLlaveNivel3", {
        self.moverLlave()
 })
        config.configurarAparicionPociones()
        game.say(personaje, "¡Nivel Final: Desafío Extremo!")
    }
method moverLlave() {
    if (alturaLlave == 2) {
        sentidoLlave = 1
    }

    if (alturaLlave == 8) {
        sentidoLlave = -1
    }

    alturaLlave += sentidoLlave
    llave.position(game.at(14, alturaLlave))
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

object gestorNiveles {
    var nivelActual = 0
    const niveles = [nivel1, nivel2, nivel3]

    method iniciarNivelActual() {
        game.clear()
        personaje.reposicionar()
        generadorPociones.reiniciar()
        niveles.get(nivelActual).iniciar()
    }

    method reiniciarAlNivelUno() {
        nivelActual = 0
        personaje.reiniciar()
        self.iniciarNivelActual()
    }

    method finDelJuego() {
        game.clear()
        game.addVisual(finAnimacion)
        game.onTick(200, "animarFin", { finAnimacion.animar() })
        game.say(finAnimacion, "¡Completaste el juego! Presioná R para reiniciar")
        keyboard.r().onPressDo({
            self.reiniciarAlNivelUno()
        })
    }

    method completarNivel() { niveles.get(nivelActual).completar() }

    method siguienteNivel() {
        nivelActual += 1
        self.iniciarNivelActual()
    }
}