import wollok.game.*

object tablero {
    method esPosicionValida(posicion) {
        return posicion.x().between(0, game.width() - 1) and 
               posicion.y().between(0, game.height() - 1)
    }

    method esLimiteIzquierdo(posicion) = posicion.x() <= 0
    method esLimiteDerecho(posicion) = posicion.x() >= game.width() - 1
    method esLimiteInferior(posicion) = posicion.y() <= 0
    method esLimiteSuperior(posicion) = posicion.y() >= game.height() - 1
}

object movimientoRandom {
    const direcciones = [haciaArriba, haciaAbajo, haciaLaIzquierda, haciaLaDerecha]

    method mover(personajeLibre) {
        const direccionElegida = direcciones.anyOne()
        movimiento.mover(personajeLibre, direccionElegida)
    }
}

object movimiento {
    method mover(personajeLibre, direccion) {
        const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
        if (tablero.esPosicionValida(nuevaPosicion)) {
            personajeLibre.position(nuevaPosicion)
        }
    }
}

object haciaArriba {
    method posicionSiguiente(posicion) = posicion.up(1)
    method opuesta() = haciaAbajo
}

object haciaAbajo {
    method posicionSiguiente(posicion) = posicion.down(1)
    method opuesta() = haciaArriba
}

object haciaLaDerecha {
    method posicionSiguiente(posicion) = posicion.right(1)
    method opuesta() = haciaLaIzquierda
}

object haciaLaIzquierda {
    method posicionSiguiente(posicion) = posicion.left(1)
    method opuesta() = haciaLaDerecha
}