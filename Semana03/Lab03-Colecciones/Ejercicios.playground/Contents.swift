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
let buscarAlumno = readLine() ?? ""

if alumnos.contains(buscarAlumno) {
    print("\(buscarAlumno) está en la lista")
} else {
    print("\(buscarAlumno) NO está en la lista")
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

print(lista)
print(lista.count)

var nombresPredict = ["Ana", "Carlos", "Beto"]

print(nombresPredict.sorted())
print(nombresPredict)


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
var valorTotalCatalogo = 0.0

for (_, precio) in productos {
    valorTotalCatalogo += precio
}

print("Valor total: S/. \(valorTotalCatalogo)")


// TODO 7: Buscar producto
print("Buscar producto:")

let buscarProducto = readLine() ?? ""

if let precioEncontrado = productos[buscarProducto] {
    print("\(buscarProducto) cuesta S/. \(precioEncontrado)")
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

// ANALYZE:
// Recorre el diccionario de edades.
// Si una persona tiene 21 años o más,
// agrega su nombre al array mayores.
// En este caso aparece Luis porque tiene 22 años.


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


// PREDICT 5 - 8
let conjuntoA: Set<Int> = [1, 2, 3, 4, 5]
let conjuntoB: Set<Int> = [4, 5, 6, 7, 8]

print(conjuntoA.intersection(conjuntoB))
print(conjuntoA.union(conjuntoB).count)
print(conjuntoA.subtracting(conjuntoB))

var repetidos: Set<String> = ["A", "B", "A", "C", "B"]

print(repetidos.count)


// ======================================================
// EJERCICIO 4: COMBINACIÓN DE COLECCIONES
// ======================================================

// TODO 10: Inventario de productos
var preciosInventario: [String: Double] = [:]
var stocksInventario: [String: Int] = [:]

print("¿Cuántos productos?")

let cantidadProductos = Int(readLine() ?? "") ?? 0

if cantidadProductos > 0 {

    for i in 1...cantidadProductos {

        print("Producto \(i) - Nombre:")
        let nombre = readLine() ?? ""

        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0

        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0

        preciosInventario[nombre] = precio
        stocksInventario[nombre] = stock
    }

} else {
    print("No se ingresaron productos")
}


// Calcular valor total
var valorTotalInventario = 0.0

for (nombre, precio) in preciosInventario {

    if let stock = stocksInventario[nombre] {
        valorTotalInventario += precio * Double(stock)
    }
}

print("===== INVENTARIO =====")

for (nombre, precio) in preciosInventario {

    if let stock = stocksInventario[nombre] {
        print("\(nombre) - Precio: S/. \(precio) - Stock: \(stock)")
    }
}

print("Valor total del inventario: S/. \(valorTotalInventario)")


// Mostrar stock bajo
print("===== STOCK BAJO =====")

var encontroStockBajo = false

for (nombre, stock) in stocksInventario {

    if stock < 5 {
        print("\(nombre) - Stock: \(stock)")
        encontroStockBajo = true
    }
}

if encontroStockBajo == false {
    print("No hay productos con stock bajo")
}


// ======================================================
// EJERCICIO 5: CARRITO DE COMPRAS 2.0
// ======================================================

// TODO 11: Pedir productos

var nombresCarrito: [String] = []
var preciosCarrito: [Double] = []
var cantidadesCarrito: [Int] = []

print("¿Cuántos productos va a comprar?")

let totalProductos = Int(readLine() ?? "") ?? 0

if totalProductos > 0 {

    for i in 1...totalProductos {

        print("\nProducto \(i) - Nombre:")
        let nombre = readLine() ?? ""
        nombresCarrito.append(nombre)

        print("Precio unitario:")
        let precio = Double(readLine() ?? "") ?? 0
        preciosCarrito.append(precio)

        print("Cantidad:")
        let cantidad = Int(readLine() ?? "") ?? 0
        cantidadesCarrito.append(cantidad)
    }

} else {
    print("No se ingresaron productos al carrito")
}


// TODO 12: Calcular subtotales

var subtotales: [Double] = []

for i in 0..<nombresCarrito.count {
    let subtotal = preciosCarrito[i] * Double(cantidadesCarrito[i])
    subtotales.append(subtotal)
}


// TODO 13: Total del carrito

var totalCarrito = 0.0

for subtotal in subtotales {
    totalCarrito += subtotal
}


// TODO 14: Nombre del cliente

print("\nNombre del cliente:")
let cliente = readLine() ?? ""


// TODO 15: Descuento

var porcentajeDescuento = 0.0

if totalCarrito >= 5000 {
    porcentajeDescuento = 0.15
} else if totalCarrito >= 2000 {
    porcentajeDescuento = 0.10
} else if totalCarrito >= 500 {
    porcentajeDescuento = 0.05
}

let descuento = totalCarrito * porcentajeDescuento
let totalConDescuento = totalCarrito - descuento


// TODO 16: IGV y total

let igv = totalConDescuento * 0.18
let totalFinal = totalConDescuento + igv


// TODO 17: Categoría del cliente

var categoria = ""

switch Int(totalCarrito) {

case 0..<500:
    categoria = "Regular"

case 500..<2000:
    categoria = "Frecuente"

case 2000..<5000:
    categoria = "VIP"

default:
    categoria = "Premium"
}


// TODO 18: Ticket

let separador = String(repeating: "=", count: 45)

print(separador)
print(" TICKET DE COMPRA 2.0")
print(" Cliente: \(cliente) (\(categoria))")
print(separador)

for i in 0..<nombresCarrito.count {
    print("\(nombresCarrito[i]) x\(cantidadesCarrito[i]) S/. \(subtotales[i])")
}

print(separador)

print("Subtotal: S/. \(totalCarrito)")

if porcentajeDescuento > 0 {
    print("Descuento (\(porcentajeDescuento * 100)%): -S/. \(descuento)")
}

print("IGV (18%): S/. \(igv)")

print(separador)

print("TOTAL: S/. \(totalFinal)")

print(separador)

print("¡Gracias por su compra, \(cliente)!")
