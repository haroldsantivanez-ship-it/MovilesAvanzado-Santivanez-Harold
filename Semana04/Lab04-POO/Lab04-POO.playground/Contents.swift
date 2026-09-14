import Cocoa

// ===== CASO 1.5: HERENCIA Y POLIMORFISMO =====

// Categorías para los electrodomésticos
enum CategoriaElectro {
    case lineaBlanca
    case tecnologia
    case pequenos
}

// Datos de cada electrodoméstico
struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

// Clase principal de las sucursales
class Sucursal {
    let nombre: String
    let ciudad: String

    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }

    func descuento() -> Double {
        return 0.05
    }

    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }

    // Este método se mantiene solo en la clase principal
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio

        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}

// Sucursal de Lima
class SucursalLima: Sucursal {

    override func descuento() -> Double {
        return 0.10
    }

    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// Sucursal de provincia
class SucursalProvincia: Sucursal {

    override func costoEnvio(monto: Double) -> Double {
        let envio = monto * 0.08

        if envio < 50 {
            return 50.0
        } else {
            return envio
        }
    }
}

// Sucursal Outlet
class SucursalOutlet: Sucursal {

    override func descuento() -> Double {
        return 0.25
    }

    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// Sucursal Online
class SucursalOnline: Sucursal {

    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}

// Productos que se usarán para las pruebas
let refrigeradora = Electrodomestico(
    nombre: "Refrigeradora",
    marca: "Frost",
    precioLista: 2000.0,
    categoria: .lineaBlanca
)

let licuadora = Electrodomestico(
    nombre: "Licuadora",
    marca: "Mix",
    precioLista: 250.0,
    categoria: .pequenos
)

// Todas las sucursales usan como tipo la clase base
let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima"),
    SucursalOnline(nombre: "Online", ciudad: "Virtual")
]

// Prueba con refrigeradora
print("===== Refrigeradora (S/ 2000.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

// Prueba con licuadora
print("===== Licuadora (S/ 250.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}

// Para agregar SucursalOnline solo fue necesario crear la nueva clase
// y añadirla al arreglo de sucursales.
// No fue necesario cambiar cotizar ni los for-in.


// ===== FIX 7 =====

// Faltaba override porque descuento() ya existe en la clase Sucursal.
// Swift necesita esa palabra para indicar que estamos reemplazando
// el comportamiento heredado.

class SucursalMall: Sucursal {

    override func descuento() -> Double {
        return 0.12
    }
}


// ===== FIX 8 =====

// La clase hija tiene una propiedad nueva llamada radioKm.
// Primero se inicializa esa propiedad y luego se llama al init de Sucursal.

class SucursalExpress: Sucursal {

    let radioKm: Int

    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        super.init(nombre: nombre, ciudad: ciudad)
    }
}


// ===== PREDICT =====

print("===== PREDICT =====")

let misteriosa: Sucursal = SucursalLima(
    nombre: "Lima Centro",
    ciudad: "Lima"
)

// PREDICT 6:
// Aunque la variable está declarada como Sucursal,
// el objeto real es SucursalLima.
// Por eso Swift usa el descuento de Lima, que es 0.10.

print(misteriosa.descuento())

let monto = 2000.0 * (1 - misteriosa.descuento())

// PREDICT 7:
// El monto queda en 1800.
// Como es mayor o igual a 1500,
// SucursalLima devuelve costo de envío 0.0.

print(misteriosa.costoEnvio(monto: monto))
