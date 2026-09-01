import UIKit

// Docente : Juan León S.

// ===== EJERCICIO 1: CONDICIONALES =====

// --- Ejemplo (ya resuelto): ---
let nota = 15.0

if nota >= 13.0 {
    print("Aprobado con \(nota)")
} else {
    print("Desaprobado con \(nota)")
}

// --- TODO 1: Validar si una persona es mayor de edad ---
let edad = 17

if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}

// --- TODO 2: Clasificar una nota con else if ---
let miNota = 16.0

if miNota >= 18 {
    print("Excelente")
} else if miNota >= 15 {
    print("Bueno")
} else if miNota >= 13 {
    print("Aprobado")
} else {
    print("Desaprobado")
}

// --- TODO 3: Verificar si un número es positivo, negativo o cero ---
let numero = -5

if numero > 0 {
    print("Positivo")
} else if numero < 0 {
    print("Negativo")
} else {
    print("Cero")
}

// --- FIX: Encuentra y corrige los 3 errores ---

let temperatura = 35

if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 {
    print("Clima agradable")
} else {
    print("Hace frío")
}

let saldo = 100.0
let compra = 150.0

if saldo > compra {
    print("Compra realizada")
} else {
    print("Saldo insuficiente: te faltan \(compra - saldo)")
}

let hora = 25

if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora <= 23 {
    print("Buenas noches")
} else {
    print("Hora inválida")
}

// --- PREDICCIONES ---

let x = 10

if x > 5 && x < 20 {
    print("Dentro del rango")
} else {
    print("Fuera del rango")
}
// PREDICT 1: Dentro del rango

let y = 15

if y > 20 {
    print("Mayor que 20")
} else if y > 10 {
    print("Mayor que 10")
} else if y > 5 {
    print("Mayor que 5")
}
// PREDICT 2: Mayor que 10
// No imprime "Mayor que 5" porque al cumplirse el primer else if,
// el resto de condiciones no se ejecutan.

let esLunes = true
let llueve = false

if esLunes && llueve {
    print("Lunes lluvioso")
} else if esLunes || llueve {
    print("Es lunes O llueve")
} else {
    print("Ni lunes ni llueve")
}
// PREDICT 3: Es lunes O llueve
// ===== EJERCICIO 2: SWITCH =====

// --- Ejemplo (ya resuelto) ---

let diaSemana = 3

switch diaSemana {
case 1:
    print("Lunes")
case 2:
    print("Martes")
case 3:
    print("Miércoles")
case 4:
    print("Jueves")
case 5:
    print("Viernes")
case 6:
    print("Sábado")
case 7:
    print("Domingo")
default:
    print("Día inválido")
}

// --- TODO 4: Clasificar nota numérica a letra ---

let notaSwitch = 16

switch notaSwitch {
case 18...20:
    print("A")
case 15...17:
    print("B")
case 13...14:
    print("C")
case 11...12:
    print("D")
case 0...10:
    print("F")
default:
    print("Nota inválida")
}
// ===== EJERCICIO 3: FOR-IN =====

// --- Ejemplo (ya resuelto) ---

for i in 1...5 {
    print("Número: \(i)")
}

// --- TODO 7: Tabla de multiplicar del 7 ---

for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---

var suma = 0

for i in 1...100 {
    suma = suma + i
}

print("La suma del 1 al 100 es: \(suma)")

// --- TODO 9: Calcular el factorial de 8 ---

var factorial = 1

for i in 1...8 {
    factorial = factorial * i
}

print("8! = \(factorial)")

// --- TODO 10: Patrón de asteriscos ---

for i in 1...5 {
    print(String(repeating: "*", count: i))
}

// ===== FIX: Encuentra los 2 errores =====

// FIX 4: Imprimir números pares del 2 al 20

for i in 2...20 {
    if i % 2 == 0 {
        print(i)
    }
}

// FIX 5: Cuenta regresiva del 10 al 1

for i in stride(from: 10, through: 1, by: -1) {
    print(i)
}

// --- PREDICCIONES ---

var total = 0

for i in 1...5 {
    total += i
}

print(total)

// PREDICT 6: Valor = 15
// PREDICT 6: Iteraciones = 5

var texto = ""

for _ in 1...3 {
    texto += "Hola "
}

print(texto)

// PREDICT 7: Hola Hola Hola
// _ se utiliza cuando no necesitamos usar el valor de la iteración.
