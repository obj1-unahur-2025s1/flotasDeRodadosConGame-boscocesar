class Corsa {
  var property color
  method initialize() {
    if (not coloresValidos.listaColores().contains(color)){
      self.error(color.toString() + "el color del rodado no es valido")
    }
  }
  method capacidad() = 4
  method velocidad() = 150
  method peso() = 1300
}

class Kwid{
  var property tanqueAdicional
  method capacidad() = if(!tanqueAdicional) 4 else 3
  method velocidad() = if(tanqueAdicional) 110 else 120
  method peso() = 1200 + if(tanqueAdicional) 150 else 0 
  method color() = 'azul'
}

object trafic{
  var property interior = comodo 
  var property motor = pulenta
  method capacidad() = interior.capacidad()
  method peso() = interior.capacidad() + motor.peso()
  method velocidad() = motor.velocidad()
  method color() = 'blanco'

  method cambiarMotor(motorDado){
    motor = motorDado
  }
}

object comodo{
  method capacidad()=5
  method peso()=700
}
object popular{
  method capacidad()=12
  method peso()=1000
}

object pulenta{
  method peso() = 800
  method velocidad() = 130
}
object bataton{
  method peso() = 500
  method velocidad() =80
}

class AutoEspecial{
  var property capacidad
  var property peso
  var property color
  const velocidad 
  method velocidad() = //LE PONES TOPE A LA VELOCIDAD. 
  velocidad.min(topeVelocidad.tope)
  // SI LE PONES TOPE A LA VELOCIDAD AGARRA EL 200 PORQUE ES EL MINIMO.
  method initialize() {
    if (not coloresValidos.listaColores().contains(color)){
      self.error(color.toString() + "el color del rodado no es valido")
    }
  }
}

class Dependencia{
  var property empleados 
  const flota = []
  const pedidos = []
  
  method agregarAFlota(rodado){flota.add(rodado)} 
  method quitarDeFlota(rodado){flota.remove(rodado)} 
  method pesoTotalFlota() = flota.sum({r => r.peso()})
  method estaBienEquipada() = /* delegar */ flota.size() and flota.all({r => r.velocidad() >= 100}) 
  method capacidadTotalEnColor(color) = /* delegar */flota.filter({r => r.color() == color }).sum({r => r.capacidad()}) 
  method colorDelRodadoMasRapido() = flota.max({r => r.velocidad()}).color()
  method capacidadFaltante() = (empleados - flota.sum({r => r.capacidad()})).max(0) 
  method esGrande() = empleados >= 40 and flota.size() >= 5

  method agregarPedido(pedidoDado) {pedidos.add(pedidoDado)}
  method quitarPedido(pedidoDado) {pedidos.remove(pedidoDado)}
  method pedidosTotalPasajeros() = pedidos.sum({p => p.pasajeros()})
  method pedidosInsatisfechos() = pedidos.filter({p => not p.rodadoPuedeHacerPedido()})
  method pedidosColorIncompatible(color) = pedidos.all({p => p.coloresIncompatibles().contains(color)})
  method relajarPedidos() = pedidos.forEach({p => p.relajar()})
  
}


class Pedidos {
  var property distancia
  var tiempoMax
  var property pasajeros
  var property coloresIncompatibles = #{}
  method agregarColorIncompatible(color) = coloresIncompatibles.add(color)
  method velocidadRequerida() = distancia / tiempoMax

  method rodadoPuedeHacerPedido(rodado) = 
    rodado.velocidad() >= self.velocidadRequerida() + 10
    && rodado.capacidad() >= pasajeros
    && not coloresIncompatibles.contains(rodado.color())

  method acelerar() {tiempoMax = 1.max(tiempoMax - 1)}
  method relajar() {tiempoMax += 1}
  method tiempoMax() = tiempoMax
  method initialize(){
    if (not distancia.isInteger()){
        self.error("La distancia tiene que ser entero")   
    }

    if (not pasajeros.isInteger()){
        self.error("La cantidad de pasajeros tiene que ser un numero entero")   
    }

    if (not tiempoMax.isInteger()){
      self.error("El tiempo tiene que ser un entero")
    }
  }
}

//etapa3

 

object topeVelocidad{
  var property tope = 200
}

object coloresValidos{
  const property listaColores = #{"rojo", "verde", "azul", "blanco"}
}