import Cocoa // permite trabajar con Swift dentro del Playground

// ===== CASO 2 - PARTE B: BIBLIOTECA CON IA =====

// Enum que representa los dos estados posibles de un libro
enum EstadoLibro {
    case disponible // indica que el libro puede ser prestado
    case prestado   // indica que el libro ya fue prestado
}

// Struct que representa la información de un libro
struct Libro {
    let titulo: String // guarda el título del libro
    let autor: String // guarda el nombre del autor
    var estado: EstadoLibro = .disponible // todo libro empieza disponible
}

// Clase que administra los libros y los préstamos
class Biblioteca {

    var libros: [Libro] = [] // arreglo donde se guardan los libros

    // Método para agregar un libro al arreglo
    func agregar(libro: Libro) {
        libros.append(libro) // añade el libro recibido al inventario
    }

    // Método para prestar un libro
    func prestar(titulo: String) -> Bool {

        // Recorre el arreglo utilizando sus posiciones
        for i in 0..<libros.count {

            // Compara el título buscado con el título del libro actual
            if libros[i].titulo == titulo {

                // Comprueba si el libro todavía está disponible
                if libros[i].estado == .disponible {

                    libros[i].estado = .prestado // cambia el estado directamente dentro del arreglo

                    print("Préstamo aprobado: \(titulo)") // informa que el préstamo fue realizado

                    return true // indica que la operación fue correcta

                } else {

                    print("Error: \(titulo) ya está prestado") // informa que el libro ya estaba prestado

                    return false // indica que no se pudo realizar el préstamo
                }
            }
        }

        print("Error: no existe \(titulo)") // se ejecuta si el libro no fue encontrado

        return false // indica que la operación no se pudo completar
    }

    // Método para devolver un libro
    func devolver(titulo: String) -> Bool {

        // Recorre todos los libros utilizando sus posiciones
        for i in 0..<libros.count {

            // Busca un libro cuyo título coincida
            if libros[i].titulo == titulo {

                // Comprueba que el libro se encuentre prestado
                if libros[i].estado == .prestado {

                    libros[i].estado = .disponible // modifica el struct directamente dentro del arreglo

                    print("Devolución registrada: \(titulo)") // informa que la devolución fue registrada

                    return true // indica que la devolución fue correcta

                } else {

                    print("Error: \(titulo) ya está disponible") // informa que no era necesario devolverlo

                    return false // indica que la operación no pudo realizarse
                }
            }
        }

        print("Error: no existe \(titulo)") // informa que el título no existe en la biblioteca

        return false // finaliza indicando que la operación falló
    }

    // Método que muestra el inventario completo
    func inventario() {

        print("===== INVENTARIO =====") // título del inventario

        // Recorre cada libro registrado
        for libro in libros {

            // Evalúa el estado actual del libro
            switch libro.estado {

            case .disponible:

                print("\(libro.titulo) (\(libro.autor)) - disponible") // muestra un libro disponible

            case .prestado:

                print("\(libro.titulo) (\(libro.autor)) - prestado") // muestra un libro prestado
            }
        }
    }
}


// ===== SIMULACIÓN =====

let biblioteca = Biblioteca() // crea una biblioteca vacía

let libro1 = Libro(
    titulo: "Cien años de soledad", // título del primer libro
    autor: "Gabriel García Márquez" // autor del primer libro
)

let libro2 = Libro(
    titulo: "La ciudad y los perros", // título del segundo libro
    autor: "Mario Vargas Llosa" // autor del segundo libro
)

let libro3 = Libro(
    titulo: "El Quijote", // título del tercer libro
    autor: "Miguel de Cervantes" // autor del tercer libro
)

biblioteca.agregar(libro: libro1) // agrega el primer libro
biblioteca.agregar(libro: libro2) // agrega el segundo libro
biblioteca.agregar(libro: libro3) // agrega el tercer libro

biblioteca.prestar(titulo: "La ciudad y los perros") // realiza el primer préstamo

biblioteca.prestar(titulo: "La ciudad y los perros") // intenta prestarlo nuevamente

biblioteca.devolver(titulo: "La ciudad y los perros") // registra la devolución

biblioteca.prestar(titulo: "El Quijote") // presta El Quijote

biblioteca.prestar(titulo: "El Principito") // prueba con un libro que no existe

biblioteca.inventario() // muestra el estado final de todos los libros
