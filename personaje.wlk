import wollok.game.*

object personaje{
    var property vida = 100
    var property energia = 50
    var property position = game.origin()

    method image() = "player.png" // Nota: tanto player como personaje falta darle identidad 

    method tomar(pocion) {
      // falta implementar logica
    }
}