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
        // game.cellSize(64)
        game.boardGround("fondo1015.png")
    }

    method configurarAcciones() {
        var personajeControlado = personaje

    keyboard.t().onPressDo({ personajeControlado = personaje })
    keyboard.up().onPressDo({ self.moverSiVive(personajeControlado, haciaArriba)})
    keyboard.down().onPressDo({ self.moverSiVive(personajeControlado, haciaAbajo)})
    keyboard.left().onPressDo({ self.moverSiVive(personajeControlado, haciaLaIzquierda)})
    keyboard.right().onPressDo({ self.moverSiVive(personajeControlado, haciaLaDerecha)})
    keyboard.r().onPressDo({ if (personaje.estaMuerto()) self.reiniciar() })
    }

    method moverSiVive(personajeLibre, direccion) {
        if (personajeLibre.estaVivo()) {
            movimiento.mover(personajeLibre, direccion)
        }
}

    // Aparece una poción aleatoria cada 5 segundos (5000 ms)
    method configurarAparicionPociones() {
        game.onTick(5000, "aparecerPocion", {
            const nuevaPocion = generadorPociones.crearPocionAleatoria()
            game.addVisual(nuevaPocion)
        })
    }

    // =========== Tick polimórfico para mover a los enemigos ===========
    method configurarMovimientoEnemigos(enemigos) {
        game.onTick(1000, "moverEnemigos", {
            enemigos.forEach({ enemigo => enemigo.movete() })
        })
    }

    // =========== Colisión polimórfica con los enemigos ===========
method configurarColisiones() {
        game.onCollideDo(personaje, { elemento =>
            elemento.teAtaca(personaje)
        })
    }

    // Cuando el pozo colisione con el personaje, lo manda a su posición inicial
    method configurarCaerEnTrampa() {
        game.onCollideDo(pozo, { alguien =>
            pozo.teAbsorbe(alguien)
        })
    }

    // Cuando la llave colisione con el personaje
    method configurarTomarLlave() {
        game.onCollideDo(llave, { alguien =>
            alguien.vida(100)
            game.say(alguien, "¡La tengo!")
            gestorNiveles.completarNivel() // Completa el nivel al tomar la llave
        })
    }

    // reinicia el juego
    method reiniciar() {
        gestorNiveles.iniciarNivelActual() // Reinicia el nivel actual
    }
}

// Lógica para implementar niveles 
object nivel1 {

    const enemigos = [fantasma1, escorpion1]

    method iniciar() {    
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigos)
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)
        
        // Agregamos todos los enemigos al mapa
        enemigos.forEach({ enemigo => game.addVisual(enemigo) })
    }
}

// Lógica para implementar niveles 

object nivel2 {

    const enemigos = [fantasma1, serpiente1, escorpion1]

    method iniciar() {  
        self.detallesVisuales()
        config.configurarAcciones()
        config.configurarColisiones()
        config.configurarMovimientoEnemigos(enemigos)
        config.configurarCaerEnTrampa()
        config.configurarTomarLlave()
        config.configurarAparicionPociones()
        game.say(personaje, "¡Entraste al nivel 2!")
    }

    method detallesVisuales() {
        game.addVisual(personaje)
        game.addVisual(llave)
        game.addVisual(pozo)
        
        // Agregamos todos los enemigos al mapa
        enemigos.forEach({ enemigo => game.addVisual(enemigo) })
    }
}

object gestorNiveles {
    var nivelActual = 1

    method iniciarNivelActual() {
    game.clear()
    personaje.reiniciar()    
    if (nivelActual == 1) {
        nivel1.iniciar()
    }
     if (nivelActual == 2) {
        nivel2.iniciar()
    }
}

method completarNivel() {
    game.say(personaje, "¡Nivel completado!")
    nivelActual = nivelActual + 1   
    self.iniciarNivelActual()
}

 
}