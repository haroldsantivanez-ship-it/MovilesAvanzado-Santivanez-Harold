import Cocoa

// ======================================================
// CASO 1.5: HERENCIA Y POLIMORFISMO
// ======================================================

// Categorías de los electrodomésticos
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

// Clase base de las sucursales
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

    // La cotización se realiza desde la clase base
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio

        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}


// ======================================================
// TIPOS DE SUCURSALES
// ======================================================

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


// ======================================================
// PRODUCTOS PARA LAS PRUEBAS
// ======================================================

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


// Todas las sucursales se guardan usando la clase base
let sucursales: [Sucursal] = [
    SucursalLima(
        nombre: "Lima Centro",
        ciudad: "Lima"
    ),

    SucursalProvincia(
        nombre: "Provincia Cusco",
        ciudad: "Cusco"
    ),

    SucursalOutlet(
        nombre: "Outlet Ate",
        ciudad: "Lima"
    ),

    SucursalOnline(
        nombre: "Online",
        ciudad: "Virtual"
    )
]


// ======================================================
// PRUEBAS DE COTIZACIÓN
// ======================================================

print("===== Refrigeradora (S/ 2000.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}


print("===== Licuadora (S/ 250.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}


// Para agregar SucursalOnline solo fue necesario crear
// la nueva clase y agregarla al arreglo de sucursales.
// No fue necesario cambiar cotizar ni los for-in.


// ======================================================
// FIX 7
// ======================================================

// Faltaba override porque descuento() ya existe en Sucursal.
// Con override indicamos que se reemplaza el método heredado.

class SucursalMall: Sucursal {

    override func descuento() -> Double {
        return 0.12
    }
}


// ======================================================
// FIX 8
// ======================================================

// Esta clase agrega la propiedad radioKm.
// Primero se inicializa esa propiedad y después
// se llama al inicializador de la clase padre.

class SucursalExpress: Sucursal {

    let radioKm: Int

    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        super.init(nombre: nombre, ciudad: ciudad)
    }
}


// ======================================================
// PREDICT 6 Y 7
// ======================================================

print("===== PREDICT =====")

let misteriosa: Sucursal = SucursalLima(
    nombre: "Lima Centro",
    ciudad: "Lima"
)

// PREDICT 6:
// Aunque la variable está declarada como Sucursal,
// el objeto que contiene realmente es SucursalLima.
// Por eso se utiliza el descuento de Lima.

print(misteriosa.descuento())


let monto = 2000.0 * (1 - misteriosa.descuento())


// PREDICT 7:
// El monto después del descuento es 1800.
// Como supera los 1500, el envío en Lima es gratuito.

print(misteriosa.costoEnvio(monto: monto))


// ======================================================
// CASO 2 - PARTE A: BIBLIOTECA SIN IA
// ======================================================

// Estado de cada libro
enum EstadoLibro {
    case disponible
    case prestado
}


// Información de un libro
struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}


// Clase que administra la biblioteca
class Biblioteca {

    var libros: [Libro] = []


    // Agrega un libro al inventario
    func agregar(libro: Libro) {
        libros.append(libro)
    }


    // Busca un libro y realiza el préstamo
    func prestar(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .disponible {

                    libros[i].estado = .prestado
                    print("Préstamo aprobado: \(titulo)")
                    return true

                } else {

                    print("Error: \(titulo) ya está prestado")
                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }


    // Busca un libro y registra su devolución
    func devolver(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .prestado {

                    libros[i].estado = .disponible
                    print("Devolución registrada: \(titulo)")
                    return true

                } else {

                    print("Error: \(titulo) ya está disponible")
                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }


    // Muestra todos los libros registrados
    func inventario() {

        print("===== INVENTARIO =====")

        for libro in libros {

            switch libro.estado {

            case .disponible:
                print("\(libro.titulo) (\(libro.autor)) - disponible")

            case .prestado:
                print("\(libro.titulo) (\(libro.autor)) - prestado")
            }
        }
    }
}


// ======================================================
// SIMULACIÓN DEL CASO 2A
// ======================================================

let biblioteca = Biblioteca()


// Se crean tres libros
let libro1 = Libro(
    titulo: "Cien años de soledad",
    autor: "Gabriel García Márquez"
)

let libro2 = Libro(
    titulo: "La ciudad y los perros",
    autor: "Mario Vargas Llosa"
)

let libro3 = Libro(
    titulo: "El Quijote",
    autor: "Miguel de Cervantes"
)


// Se agregan los libros a la biblioteca
biblioteca.agregar(libro: libro1)
biblioteca.agregar(libro: libro2)
biblioteca.agregar(libro: libro3)


// ======================================================
// PRUEBAS DE LA BIBLIOTECA
// ======================================================

// Préstamo correcto
biblioteca.prestar(
    titulo: "La ciudad y los perros"
)


// Se intenta prestar nuevamente el mismo libro
biblioteca.prestar(
    titulo: "La ciudad y los perros"
)


// Se devuelve el libro
biblioteca.devolver(
    titulo: "La ciudad y los perros"
)


// Se presta otro libro
biblioteca.prestar(
    titulo: "El Quijote"
)


// Se intenta prestar un libro que no existe
biblioteca.prestar(
    titulo: "El Principito"
)


// Se muestra el inventario final
biblioteca.inventario()
