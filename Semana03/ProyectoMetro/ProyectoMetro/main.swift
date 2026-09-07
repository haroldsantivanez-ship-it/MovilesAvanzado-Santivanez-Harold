import Foundation

let lineas = ["L1", "L2", "L3", "L4", "L5", "L6"]

let estadosLineas: [String: String] = [
    "L1": "Operativa",
    "L2": "Operación parcial / en construcción",
    "L3": "Proyectada",
    "L4": "En construcción / proyectada",
    "L5": "Proyectada",
    "L6": "Proyectada"
]

let estacionesPorLinea: [String: [String]] = [
    "L1": [
        "Villa El Salvador",
        "Parque Industrial",
        "Pumacahua",
        "Villa María",
        "María Auxiliadora",
        "San Juan",
        "Atocongo",
        "Jorge Chávez",
        "Ayacucho",
        "Cabitos",
        "Angamos",
        "San Borja Sur",
        "La Cultura",
        "Arriola",
        "Gamarra",
        "Grau",
        "El Ángel",
        "Presbítero Maestro",
        "Caja de Agua",
        "Pirámide del Sol",
        "Los Jardines",
        "Los Postes",
        "San Carlos",
        "San Martín",
        "Santa Rosa",
        "Bayóvar"
    ],

    "L2": [
        "Puerto del Callao",
        "Buenos Aires",
        "Juan Pablo II",
        "Insurgentes",
        "Carmen de la Legua",
        "Óscar Benavides",
        "San Marcos",
        "Elio",
        "La Alborada",
        "Tingo María",
        "Parque Murillo",
        "Plaza Bolognesi",
        "Estación Central",
        "Plaza Manco Cápac",
        "Cangallo",
        "28 de Julio",
        "Nicolás Ayllón",
        "Circunvalación",
        "San Juan de Dios",
        "Evitamiento",
        "Óvalo Santa Anita",
        "Colectora Industrial",
        "Hermilio Valdizán",
        "Mercado Santa Anita",
        "Vista Alegre",
        "Prolongación Javier Prado",
        "Municipalidad de Ate"
    ],

    "L3": [],

    "L4": [
        "Gambetta",
        "Canta Callao",
        "Bocanegra",
        "Aeropuerto",
        "El Olivar",
        "Quilca",
        "Morales Duárez",
        "Carmen de la Legua"
    ],

    "L5": [],

    "L6": []
]

let conexiones: [String: [String]] = [
    "Carmen de la Legua": ["L2", "L4"]
]

func normalizarTexto(_ texto: String) -> String {
    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        .lowercased()
}

func mostrarMenu() {
    print("\n=============================================")
    print("       METRO DE LIMA Y CALLAO")
    print("=============================================")
    print("1. Ver líneas")
    print("2. Ver estaciones de una línea")
    print("3. Buscar estación")
    print("4. Ver conexiones")
    print("5. Calcular ruta")
    print("6. Ver estado de las líneas")
    print("7. Salir")
    print("=============================================")
    print("Seleccione una opción: ", terminator: "")
}

func mostrarLineas() {
    print("\n--- LÍNEAS DEL METRO ---")

    for linea in lineas {
        print("- \(linea)")
    }
}

func mostrarEstaciones() {
    print("\nIngrese la línea (L1, L2, L3, L4, L5 o L6): ", terminator: "")

    if let entrada = readLine() {
        let linea = entrada
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        if let estaciones = estacionesPorLinea[linea] {

            if estaciones.isEmpty {
                print("\n\(linea) no tiene estaciones registradas en esta versión.")
            } else {
                print("\n--- ESTACIONES DE \(linea) ---")

                for (indice, estacion) in estaciones.enumerated() {
                    print("\(indice + 1). \(estacion)")
                }
            }

        } else {
            print("\nLa línea ingresada no es válida.")
        }
    }
}

func buscarEstacion() {
    print("\nIngrese el nombre de la estación: ", terminator: "")

    guard let entrada = readLine() else {
        return
    }

    let busqueda = normalizarTexto(entrada)
    var encontrada = false

    for linea in lineas {

        guard let estaciones = estacionesPorLinea[linea] else {
            continue
        }

        for estacion in estaciones {

            if normalizarTexto(estacion) == busqueda {
                print("\nLa estación \(estacion) pertenece a la \(linea).")
                encontrada = true
            }
        }
    }

    if !encontrada {
        print("\nNo se encontró la estación ingresada.")
    }
}

func mostrarConexiones() {
    print("\n--- CONEXIONES REGISTRADAS ---")

    for (estacion, lineasConectadas) in conexiones.sorted(by: { $0.key < $1.key }) {
        print("\(estacion): \(lineasConectadas.joined(separator: " - "))")
    }
}

var continuar = true

while continuar {

    mostrarMenu()

    if let opcion = readLine() {

        let opcionLimpia = opcion.trimmingCharacters(in: .whitespacesAndNewlines)

        switch opcionLimpia {

        case "1":
            mostrarLineas()

        case "2":
            mostrarEstaciones()

        case "3":
            buscarEstacion()

        case "4":
            mostrarConexiones()

        case "7":
            print("\nGracias por utilizar el sistema.")
            continuar = false

        case "5", "6":
            print("\nEsta opción se implementará en los siguientes pasos.")

        default:
            print("\nOpción no válida. Intente nuevamente.")
        }
    }
}
