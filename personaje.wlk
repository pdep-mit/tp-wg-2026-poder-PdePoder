import wollok.game.*

object personaje{
  var property vida = 100
  var property energia = 50
  var property position = game.origin()

  method image() = "lionel10.png" // Nota: tanto player como personaje falta darle identidad 

  method recibirDanio(cantidad) {
    vida -= cantidad 
  }
  method tomar(pocion) {
    // falta implementar logica
  }

}

object llave{
  var property position = game.at(14,8)
  method image() = "llave.png"

}