// Desarrollado por: Harold Eduardo Santivanez Garcia
// Ejercicio 1: Arrays

import Foundation

// ======================================================
// TODO 1: REGISTRO DE 5 ALUMNOS
// ======================================================

var alumnos: [String] = []

for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}

print("Alumnos: \(alumnos)")


// ======================================================
// TODO 2: BUSCAR UN ALUMNO
// ======================================================

print("Buscar alumno:")
let buscar = readLine() ?? ""

if alumnos.contains(buscar) {
    print("\(buscar) está en la lista")
} else {
    print("\(buscar) NO está en la lista")
}


// ======================================================
// TODO 3: NOTAS CON CLASIFICACIÓN
// ======================================================

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


// ======================================================
// FIX: CORRECCIÓN DE LOS 3 ERRORES
// ======================================================

// FIX 1:
// El array frutas guarda String, por eso no se puede agregar el número 7.
// Se cambia por un texto.

var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Pera")

print("Frutas: \(frutas)")


// FIX 2:
// colores debe ser var porque vamos a modificar el array con append.

var colores = ["Rojo", "Azul", "Verde"]
colores.append("Amarillo")

print("Colores: \(colores)")


// FIX 3:
// El último índice válido es 4 porque el array tiene 5 elementos.
// numeros[5] causaría un error porque esa posición no existe.

let numerosFix = [10, 20, 30, 40, 50]
print(numerosFix[4])


// ======================================================
// PREDICT
// ======================================================

var lista = [1, 2, 3, 4, 5]

lista.remove(at: 0)
lista.append(6)

// PREDICT 1:
// Se elimina el 1 y se agrega el 6.
// Resultado: [2, 3, 4, 5, 6]

print(lista)


// PREDICT 2:
// El array sigue teniendo 5 elementos.

print(lista.count)


// PREDICT 3:
// sorted() devuelve un nuevo array ordenado alfabéticamente.
// Resultado: ["Ana", "Beto", "Carlos"]

var nombresPredict = ["Ana", "Carlos", "Beto"]
print(nombresPredict.sorted())


// PREDICT 4:
// sorted() no modifica el array original.
// Resultado: ["Ana", "Carlos", "Beto"]

print(nombresPredict)
