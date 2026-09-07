import Foundation

// MARK: - Datos principales

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


// MARK: - Lugares y referencias cercanas

let lugaresCercanos: [String: [String]] = [

    // LÍNEA 1

    "Villa El Salvador": [
        "Zona urbana de Villa El Salvador",
        "Avenida Separadora Industrial",
        "Zona comercial de Villa El Salvador"
    ],

    "Parque Industrial": [
        "Parque Industrial de Villa El Salvador",
        "Zona industrial de Villa El Salvador",
        "Avenida El Sol"
    ],

    "Pumacahua": [
        "Avenida Pachacútec",
        "Zona residencial de Villa El Salvador",
        "Sector Pumacahua"
    ],

    "Villa María": [
        "Villa María del Triunfo",
        "Avenida Pachacútec",
        "Zona comercial de Villa María"
    ],

    "María Auxiliadora": [
        "Hospital María Auxiliadora",
        "Avenida Pachacútec",
        "Zona urbana de San Juan de Miraflores"
    ],

    "San Juan": [
        "San Juan de Miraflores",
        "Avenida Los Héroes",
        "Zona comercial de San Juan"
    ],

    "Atocongo": [
        "Puente Atocongo",
        "Panamericana Sur",
        "Zona comercial de Atocongo"
    ],

    "Jorge Chávez": [
        "Avenida Jorge Chávez",
        "Zona residencial de Santiago de Surco",
        "Avenida Tomás Marsano"
    ],

    "Ayacucho": [
        "Avenida Ayacucho",
        "Santiago de Surco",
        "Avenida Tomás Marsano"
    ],

    "Cabitos": [
        "Óvalo Higuereta",
        "Avenida Aviación",
        "Avenida Benavides"
    ],

    "Angamos": [
        "Avenida Angamos",
        "Avenida Aviación",
        "Zona comercial de San Borja"
    ],

    "San Borja Sur": [
        "Avenida San Borja Sur",
        "Zona residencial de San Borja",
        "Avenida Aviación"
    ],

    "La Cultura": [
        "Ministerio de Cultura",
        "Museo de la Nación",
        "Gran Teatro Nacional"
    ],

    "Arriola": [
        "Avenida Nicolás Arriola",
        "Avenida Aviación",
        "Zona comercial de La Victoria"
    ],

    "Gamarra": [
        "Emporio Comercial de Gamarra",
        "Parque Cánepa",
        "Zona comercial de Gamarra"
    ],

    "Grau": [
        "Hospital Nacional Dos de Mayo",
        "Avenida Grau",
        "Zona de Barrios Altos"
    ],

    "El Ángel": [
        "Cementerio El Ángel",
        "Avenida Áncash",
        "Zona de Barrios Altos"
    ],

    "Presbítero Maestro": [
        "Cementerio Presbítero Maestro",
        "Museo Cementerio Presbítero Maestro",
        "Avenida Áncash"
    ],

    "Caja de Agua": [
        "Avenida Próceres de la Independencia",
        "Zona de Caja de Agua",
        "San Juan de Lurigancho"
    ],

    "Pirámide del Sol": [
        "Avenida Próceres de la Independencia",
        "Zona de Pirámide del Sol",
        "San Juan de Lurigancho"
    ],

    "Los Jardines": [
        "Zona de Los Jardines",
        "Avenida Próceres de la Independencia",
        "San Juan de Lurigancho"
    ],

    "Los Postes": [
        "Avenida Los Postes",
        "Avenida Próceres de la Independencia",
        "Zona comercial de San Juan de Lurigancho"
    ],

    "San Carlos": [
        "Avenida Próceres de la Independencia",
        "Zona de San Carlos",
        "San Juan de Lurigancho"
    ],

    "San Martín": [
        "Zona de San Martín",
        "Avenida Próceres de la Independencia",
        "San Juan de Lurigancho"
    ],

    "Santa Rosa": [
        "Zona de Santa Rosa",
        "Avenida Próceres de la Independencia",
        "San Juan de Lurigancho"
    ],

    "Bayóvar": [
        "Avenida Fernando Wiesse",
        "Zona de Bayóvar",
        "San Juan de Lurigancho"
    ],


    // LÍNEA 2

    "Puerto del Callao": [
        "Puerto del Callao",
        "Centro Histórico del Callao",
        "Zona portuaria del Callao"
    ],

    "Buenos Aires": [
        "Zona de Buenos Aires del Callao",
        "Avenida Guardia Chalaca",
        "Zona urbana del Callao"
    ],

    "Juan Pablo II": [
        "Avenida Juan Pablo II",
        "Zona urbana del Callao",
        "Avenida Óscar Benavides"
    ],

    "Insurgentes": [
        "Avenida Insurgentes",
        "Zona urbana del Callao",
        "Avenida Óscar Benavides"
    ],

    "Carmen de la Legua": [
        "Distrito de Carmen de la Legua Reynoso",
        "Avenida Óscar Benavides",
        "Zona comercial de Carmen de la Legua"
    ],

    "Óscar Benavides": [
        "Avenida Óscar Benavides",
        "Zona industrial del Callao",
        "Zona urbana del Callao"
    ],

    "San Marcos": [
        "Universidad Nacional Mayor de San Marcos",
        "Ciudad Universitaria de San Marcos",
        "Avenida Universitaria"
    ],

    "Elio": [
        "Avenida Enrique Meiggs",
        "Zona de Elio",
        "Cercado de Lima"
    ],

    "La Alborada": [
        "Urbanización La Alborada",
        "Cercado de Lima",
        "Zona residencial cercana"
    ],

    "Tingo María": [
        "Avenida Tingo María",
        "Cercado de Lima",
        "Zona comercial de Breña"
    ],

    "Parque Murillo": [
        "Parque Murillo",
        "Breña",
        "Zona urbana de Lima"
    ],

    "Plaza Bolognesi": [
        "Plaza Bolognesi",
        "Avenida Brasil",
        "Centro de Lima"
    ],

    "Estación Central": [
        "Centro Cívico de Lima",
        "Real Plaza Centro Cívico",
        "Paseo de los Héroes Navales"
    ],

    "Plaza Manco Cápac": [
        "Plaza Manco Cápac",
        "La Victoria",
        "Avenida Manco Cápac"
    ],

    "Cangallo": [
        "Jirón Cangallo",
        "Barrios Altos",
        "Cercado de Lima"
    ],

    "28 de Julio": [
        "Avenida 28 de Julio",
        "La Victoria",
        "Zona comercial cercana"
    ],

    "Nicolás Ayllón": [
        "Avenida Nicolás Ayllón",
        "Zona urbana de La Victoria",
        "Zona comercial cercana"
    ],

    "Circunvalación": [
        "Avenida Circunvalación",
        "Avenida Nicolás Ayllón",
        "Zona industrial cercana"
    ],

    "San Juan de Dios": [
        "Zona de San Juan de Dios",
        "Avenida Nicolás Ayllón",
        "Distrito de El Agustino"
    ],

    "Evitamiento": [
        "Vía de Evitamiento",
        "Avenida Nicolás Ayllón",
        "Zona de Santa Anita"
    ],

    "Óvalo Santa Anita": [
        "Óvalo Santa Anita",
        "Carretera Central",
        "Zona comercial de Santa Anita"
    ],

    "Colectora Industrial": [
        "Avenida Colectora Industrial",
        "Zona industrial de Santa Anita",
        "Carretera Central"
    ],

    "Hermilio Valdizán": [
        "Avenida Hermilio Valdizán",
        "Distrito de Santa Anita",
        "Zona residencial cercana"
    ],

    "Mercado Santa Anita": [
        "Mercado Mayorista de Santa Anita",
        "Zona comercial de Santa Anita",
        "Carretera Central"
    ],

    "Vista Alegre": [
        "Zona de Vista Alegre",
        "Distrito de Ate",
        "Carretera Central"
    ],

    "Prolongación Javier Prado": [
        "Prolongación Javier Prado",
        "Distrito de Ate",
        "Zona comercial de Ate"
    ],

    "Municipalidad de Ate": [
        "Municipalidad Distrital de Ate",
        "Plaza de Armas de Ate",
        "Zona central de Ate"
    ],


    // RAMAL LÍNEA 4

    "Gambetta": [
        "Avenida Néstor Gambetta",
        "Zona industrial del Callao",
        "Zona portuaria cercana"
    ],

    "Canta Callao": [
        "Avenida Canta Callao",
        "Avenida Néstor Gambetta",
        "Zona urbana del Callao"
    ],

    "Bocanegra": [
        "Zona de Bocanegra",
        "Avenida Faucett",
        "Callao"
    ],

    "Aeropuerto": [
        "Aeropuerto Internacional Jorge Chávez",
        "Avenida Elmer Faucett",
        "Zona aeroportuaria del Callao"
    ],

    "El Olivar": [
        "Zona de El Olivar",
        "Avenida Elmer Faucett",
        "Callao"
    ],

    "Quilca": [
        "Avenida Quilca",
        "Avenida Elmer Faucett",
        "Zona urbana del Callao"
    ],

    "Morales Duárez": [
        "Avenida Morales Duárez",
        "Avenida Elmer Faucett",
        "Zona industrial del Callao"
    ]
]


// MARK: - Conexiones

let conexiones: [String: [String]] = [
    "Carmen de la Legua": ["L2", "L4"]
]


// MARK: - Funciones auxiliares

func normalizarTexto(_ texto: String) -> String {
    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: .current
        )
        .lowercased()
}

func convertirALinea(_ texto: String) -> String? {

    let valor = normalizarTexto(texto)
        .replacingOccurrences(of: " ", with: "")

    switch valor {

    case "l1", "linea1":
        return "L1"

    case "l2", "linea2":
        return "L2"

    case "l3", "linea3":
        return "L3"

    case "l4", "linea4":
        return "L4"

    case "l5", "linea5":
        return "L5"

    case "l6", "linea6":
        return "L6"

    default:
        return nil
    }
}

func buscarNombreReal(_ nombre: String) -> String? {

    let buscado = normalizarTexto(nombre)

    for linea in lineas {

        guard let estaciones = estacionesPorLinea[linea] else {
            continue
        }

        for estacion in estaciones {

            if normalizarTexto(estacion) == buscado {
                return estacion
            }
        }
    }

    return nil
}

func obtenerLineasDeEstacion(_ estacion: String) -> [String] {

    var resultado: [String] = []

    for linea in lineas {

        if estacionesPorLinea[linea]?.contains(estacion) == true {
            resultado.append(linea)
        }
    }

    return resultado
}


// MARK: - Menú

func mostrarMenu() {

    print("\n=============================================")
    print("       METRO DE LIMA Y CALLAO")
    print("=============================================")
    print("1. Ver líneas")
    print("2. Ver estaciones de una línea")
    print("3. Buscar línea o estación")
    print("4. Ver conexiones")
    print("5. Calcular ruta")
    print("6. Ver estado de las líneas")
    print("7. Salir")
    print("=============================================")
    print("Seleccione una opción: ", terminator: "")
}


// MARK: - Opción 1

func mostrarLineas() {

    print("\n--- LÍNEAS DEL METRO ---")

    for linea in lineas {

        let estado = estadosLineas[linea] ?? "Sin información"

        print("\(linea) - \(estado)")
    }
}


// MARK: - Mostrar estaciones

func listarEstaciones(de linea: String) {

    guard let estaciones = estacionesPorLinea[linea] else {
        print("\nLa línea ingresada no existe.")
        return
    }

    print("\n--- \(linea) ---")
    print("Estado: \(estadosLineas[linea] ?? "Sin información")")

    if estaciones.isEmpty {

        print("No tiene estaciones registradas en esta versión.")
        return
    }

    print("\nEstaciones:")

    for (indice, estacion) in estaciones.enumerated() {
        print("\(indice + 1). \(estacion)")
    }

    print("\nTotal de estaciones: \(estaciones.count)")
}


// MARK: - Opción 2

func mostrarEstaciones() {

    print("\nIngrese una línea: ", terminator: "")

    guard let entrada = readLine() else {
        return
    }

    guard let linea = convertirALinea(entrada) else {

        print("\nLa línea ingresada no es válida.")
        return
    }

    listarEstaciones(de: linea)
}


// MARK: - Opción 3

func buscarLineaOEstacion() {

    print("\nIngrese una línea o estación: ", terminator: "")

    guard let entrada = readLine() else {
        return
    }

    // Primero verificamos si escribió una línea

    if let linea = convertirALinea(entrada) {

        listarEstaciones(de: linea)
        return
    }

    // Si no es una línea, buscamos una estación

    guard let estacion = buscarNombreReal(entrada) else {

        print("\nNo se encontró la línea o estación ingresada.")
        return
    }

    let lineasEstacion = obtenerLineasDeEstacion(estacion)

    print("\n=============================================")
    print("ESTACIÓN ENCONTRADA")
    print("=============================================")

    print("Estación: \(estacion)")
    print("Línea: \(lineasEstacion.joined(separator: " / "))")

    print("\n--- LUGARES Y REFERENCIAS CERCANAS ---")

    if let lugares = lugaresCercanos[estacion],
       !lugares.isEmpty {

        for lugar in lugares {
            print("- \(lugar)")
        }

    } else {

        print("No hay referencias cercanas registradas.")
    }

    if let lineasConexion = conexiones[estacion] {

        print("\nConexión disponible:")
        print(lineasConexion.joined(separator: " ↔ "))
    }
}


// MARK: - Opción 4

func mostrarConexiones() {

    print("\n--- CONEXIONES REGISTRADAS ---")

    for (estacion, lineasConectadas) in conexiones.sorted(
        by: { $0.key < $1.key }
    ) {

        print(
            "\(estacion): \(lineasConectadas.joined(separator: " ↔ "))"
        )
    }
}


// MARK: - Grafo para rutas

func crearGrafo() -> [String: [String]] {

    var grafo: [String: [String]] = [:]

    for linea in lineas {

        guard let estaciones = estacionesPorLinea[linea] else {
            continue
        }

        guard estaciones.count >= 2 else {
            continue
        }

        for indice in 0..<(estaciones.count - 1) {

            let estacionActual = estaciones[indice]
            let estacionSiguiente = estaciones[indice + 1]

            grafo[estacionActual, default: []]
                .append(estacionSiguiente)

            grafo[estacionSiguiente, default: []]
                .append(estacionActual)
        }
    }

    return grafo
}


// MARK: - Calcular ruta

func calcularRuta(
    origen: String,
    destino: String
) -> [String]? {

    let grafo = crearGrafo()

    var cola: [[String]] = [[origen]]

    var visitadas: Set<String> = [origen]

    while !cola.isEmpty {

        let rutaActual = cola.removeFirst()

        guard let estacionActual = rutaActual.last else {
            continue
        }

        if estacionActual == destino {
            return rutaActual
        }

        for vecino in grafo[estacionActual] ?? [] {

            if !visitadas.contains(vecino) {

                visitadas.insert(vecino)

                var nuevaRuta = rutaActual

                nuevaRuta.append(vecino)

                cola.append(nuevaRuta)
            }
        }
    }

    return nil
}


// MARK: - Detectar línea entre estaciones

func lineaEntre(
    _ estacion1: String,
    _ estacion2: String
) -> String? {

    for linea in lineas {

        guard let estaciones = estacionesPorLinea[linea] else {
            continue
        }

        guard
            let posicion1 = estaciones.firstIndex(of: estacion1),
            let posicion2 = estaciones.firstIndex(of: estacion2)
        else {
            continue
        }

        if abs(posicion1 - posicion2) == 1 {
            return linea
        }
    }

    return nil
}


// MARK: - Opción 5

func mostrarRuta() {

    print("\n--- CALCULAR RUTA ---")

    print("Estación de origen: ", terminator: "")

    guard
        let entradaOrigen = readLine(),
        let origen = buscarNombreReal(entradaOrigen)
    else {

        print("\nLa estación de origen no fue encontrada.")
        return
    }

    print("Estación de destino: ", terminator: "")

    guard
        let entradaDestino = readLine(),
        let destino = buscarNombreReal(entradaDestino)
    else {

        print("\nLa estación de destino no fue encontrada.")
        return
    }

    if origen == destino {

        print("\nLa estación de origen y destino son la misma.")
        return
    }

    guard let ruta = calcularRuta(
        origen: origen,
        destino: destino
    ) else {

        print("\nNo existe una ruta disponible entre esas estaciones.")
        return
    }

    print("\n=============================================")
    print("RUTA ENCONTRADA")
    print("=============================================")

    for (indice, estacion) in ruta.enumerated() {

        print("\(indice + 1). \(estacion)")
    }

    print("\nTotal de estaciones: \(ruta.count)")
    print("Tramos recorridos: \(ruta.count - 1)")

    var lineaAnterior: String?
    var transbordos = 0

    if ruta.count >= 2 {

        for indice in 0..<(ruta.count - 1) {

            let actual = ruta[indice]
            let siguiente = ruta[indice + 1]

            if let lineaActual = lineaEntre(
                actual,
                siguiente
            ) {

                if let anterior = lineaAnterior,
                   anterior != lineaActual {

                    transbordos += 1

                    print(
                        "Transbordo en \(actual): \(anterior) → \(lineaActual)"
                    )
                }

                lineaAnterior = lineaActual
            }
        }
    }

    if transbordos == 0 {

        print("No se requieren transbordos.")

    } else {

        print("Total de transbordos: \(transbordos)")
    }
}


// MARK: - Opción 6

func mostrarEstados() {

    print("\n--- ESTADO DE LAS LÍNEAS ---")

    for linea in lineas {

        let estado = estadosLineas[linea]
            ?? "Sin información"

        print("\(linea): \(estado)")
    }
}


// MARK: - Programa principal

var continuar = true

while continuar {

    mostrarMenu()

    guard let opcion = readLine() else {
        continue
    }

    let opcionLimpia = opcion
        .trimmingCharacters(in: .whitespacesAndNewlines)

    switch opcionLimpia {

    case "1":
        mostrarLineas()

    case "2":
        mostrarEstaciones()

    case "3":
        buscarLineaOEstacion()

    case "4":
        mostrarConexiones()

    case "5":
        mostrarRuta()

    case "6":
        mostrarEstados()

    case "7":
        print("\nGracias por utilizar el Sistema de Consulta del Metro de Lima y Callao.")
        continuar = false

    default:
        print("\nOpción no válida. Intente nuevamente.")
    }
}
