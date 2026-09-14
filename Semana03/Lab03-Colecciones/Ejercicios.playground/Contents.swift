// Desarrollado por: Harold Eduardo Santivanez Garcia

import Foundation

// ======================================================
// EJERCICIO 1: ARRAYS
// ======================================================

// TODO 1: Registro de 5 alumnos
var alumnos: [String] = []

for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}

print("Alumnos: \(alumnos)")


// TODO 2: Buscar un alumno
print("Buscar alumno:")
let buscar = readLine() ?? ""

if alumnos.contains(buscar) {
    print("\(buscar) está en la lista")
} else {
    print("\(buscar) NO está en la lista")
}


// TODO 3: Notas con clasificación
var notasClase: [Double] = []

for i in 1...5 {
    print("Nota del alumno \(i):")
    let nota = Double(readLine() ?? "") ?? 0
    notasClase.append(nota)
}

var aprobados = 0
var desaprobados = 0
var sumaNotas = 0.0

for nota in notasClase {
    sumaNotas += nota

    if nota >= 13 {
        aprobados += 1
    } else {
        desaprobados += 1
    }
}

let promedio = sumaNotas / Double(notasClase.count)

print("Promedio: \(promedio)")
print("Aprobados: \(aprobados)")
print("Desaprobados: \(desaprobados)")


// FIX 1
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Pera")
print("Frutas: \(frutas)")


// FIX 2
var colores = ["Rojo", "Azul", "Verde"]
colores.append("Amarillo")
print("Colores: \(colores)")


// FIX 3
let numerosFix = [10, 20, 30, 40, 50]
print(numerosFix[4])


// PREDICT 1 - 4
var lista = [1, 2, 3, 4, 5]

lista.remove(at: 0)
lista.append(6)

print(lista)              // [2, 3, 4, 5, 6]
print(lista.count)        // 5

var nombresPredict = ["Ana", "Carlos", "Beto"]

print(nombresPredict.sorted()) // ["Ana", "Beto", "Carlos"]
print(nombresPredict)          // ["Ana", "Carlos", "Beto"]


// ======================================================
// EJERCICIO 2: DICCIONARIOS
// ======================================================

// TODO 4: Catálogo de productos
var productos: [String: Double] = [:]

for i in 1...4 {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""

    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0

    productos[nombre] = precio
}


// TODO 5: Mostrar catálogo
print("===== CATÁLOGO =====")

for (nombre, precio) in productos {
    print("\(nombre): S/. \(precio)")
}


// TODO 6: Valor total
var valorTotal = 0.0

for (_, precio) in productos {
    valorTotal += precio
}

print("Valor total: S/. \(valorTotal)")


// TODO 7: Buscar producto
print("Buscar producto:")
let buscarProd = readLine() ?? ""

if let precioEncontrado = productos[buscarProd] {
    print("\(buscarProd) cuesta S/. \(precioEncontrado)")
} else {
    print("Producto no encontrado")
}


// ANALYZE
var edades: [String: Int] = [
    "Ana": 20,
    "Luis": 22,
    "María": 19
]

var mayores: [String] = []

for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre)
    }
}

print("Mayores de 21: \(mayores)")

// ANALYZE 1:
// Recorre el diccionario de edades.
// Si una persona tiene 21 años o más,
// guarda su nombre en el array mayores.
// En este caso imprime a Luis porque tiene 22 años.


// ======================================================
// EJERCICIO 3: SETS
// ======================================================

// TODO 8: Eliminar duplicados
var numeros: [Int] = []

for i in 1...8 {
    print("Número \(i):")
    let numero = Int(readLine() ?? "") ?? 0
    numeros.append(numero)
}

print("Con duplicados: \(numeros)")

let sinDuplicados = Array(Set(numeros)).sorted()

print("Sin duplicados: \(sinDuplicados)")


// TODO 9: Comparar asistencia

var asistenciaLunes: Set<String> = []
var asistenciaMartes: Set<String> = []

print("===== ASISTENCIA LUNES =====")

for i in 1...4 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    asistenciaLunes.insert(nombre)
}

print("===== ASISTENCIA MARTES =====")

for i in 1...4 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    asistenciaMartes.insert(nombre)
}

let ambosDias = asistenciaLunes.intersection(asistenciaMartes)
let soloLunes = asistenciaLunes.subtracting(asistenciaMartes)
let soloMartes = asistenciaMartes.subtracting(asistenciaLunes)

print("Asistieron ambos días: \(ambosDias)")
print("Solo lunes: \(soloLunes)")
print("Solo martes: \(soloMartes)")


// ======================================================
// PREDICT 5 - 8
// ======================================================

let conjuntoA: Set<Int> = [1, 2, 3, 4, 5]
let conjuntoB: Set<Int> = [4, 5, 6, 7, 8]

// PREDICT 5:
// Los valores que están en ambos conjuntos son 4 y 5.

print(conjuntoA.intersection(conjuntoB))


// PREDICT 6:
// La unión contiene los números del 1 al 8.
// Por eso el total es 8.

print(conjuntoA.union(conjuntoB).count)


// PREDICT 7:
// Los valores que están en A pero no en B son 1, 2 y 3.

print(conjuntoA.subtracting(conjuntoB))


// PREDICT 8:
// Un Set no permite elementos repetidos.
// Solo quedan A, B y C, por eso count es 3.

var repetidos: Set<String> = ["A", "B", "A", "C", "B"]

print(repetidos.count)
