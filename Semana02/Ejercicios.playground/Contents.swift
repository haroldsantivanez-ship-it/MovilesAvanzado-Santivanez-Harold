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
// ===== EJERCICIO 4: WHILE Y REPEAT-WHILE =====

// --- Ejemplo (ya resuelto): ---

var contador = 5

while contador > 0 {
    print("Cuenta regresiva: \(contador)")
    contador -= 1
}

print("¡Despegue!")


// --- TODO 11: Ahorro mensual ---

// Un alumno ahorra S/. 150 cada mes.
// ¿Cuántos meses necesita para juntar S/. 2000?

var ahorro = 0.0
var meses = 0
let meta = 2000.0
let ahorroMensual = 150.0

while ahorro < meta {
    ahorro += ahorroMensual
    meses += 1
}

print("Necesita \(meses) meses para juntar S/. \(meta)")


// --- TODO 12: División sucesiva ---

// Divide un número entre 2 repetidamente
// hasta que sea menor a 1.

// IMPORTANTE:
// Se usa "numeroDivision" para no chocar
// con la variable "numero" del Ejercicio 1.

var numeroDivision = 1000.0
var divisiones = 0

while numeroDivision >= 1 {
    numeroDivision = numeroDivision / 2
    divisiones += 1
    print("División \(divisiones): \(numeroDivision)")
}

print("Se dividió \(divisiones) veces")


// --- TODO 13: Validar datos con repeat-while ---

// Simulamos tres intentos:
// 25 -> inválido
// -3 -> inválido
// 15 -> válido

let intento1 = 25
let intento2 = -3
let intento3 = 15

var intentoActual = intento1
var esValido = false
var numIntento = 1

repeat {

    if intentoActual >= 0 && intentoActual <= 20 {
        esValido = true
        print("Nota \(intentoActual) válida en intento \(numIntento)")
    } else {
        print("Nota \(intentoActual) inválida, intento \(numIntento)")

        // Simula el siguiente intento
        if numIntento == 1 {
            intentoActual = intento2
        }

        if numIntento == 2 {
            intentoActual = intento3
        }

        numIntento += 1
    }

} while !esValido


// --- PREDICCIONES ---

var valorA = 100
var vueltasA = 0

while valorA > 1 {
    valorA = valorA / 3
    vueltasA += 1
}

print("Valor final: \(valorA)")
print("Vueltas: \(vueltasA)")

// PREDICT 8:
// Valor final = 1
// Vueltas = 5


var valorB = 0

repeat {
    valorB += 1
} while valorB < 0

print("Valor final de b: \(valorB)")

// PREDICT 9:
// Valor = 1

// repeat-while ejecuta el bloque al menos una vez
// porque primero ejecuta el código y después evalúa
// la condición.
// ===== EJERCICIO 5: CARRITO DE COMPRAS =====

// --- Datos de productos ---

let prod1 = "Laptop"
let precio1 = 3500.0
let cant1 = 1

let prod2 = "Mouse"
let precio2 = 45.50
let cant2 = 2

let prod3 = "Teclado"
let precio3 = 120.00
let cant3 = 1

let prod4 = "Monitor"
let precio4 = 890.00
let cant4 = 1

let prod5 = "USB Cable"
let precio5 = 15.00
let cant5 = 3

// --- TODO 14: Calcular subtotales ---

let sub1 = precio1 * Double(cant1)
let sub2 = precio2 * Double(cant2)
let sub3 = precio3 * Double(cant3)
let sub4 = precio4 * Double(cant4)
let sub5 = precio5 * Double(cant5)

// --- TODO 15: Calcular subtotal general ---

let subtotalGeneral = sub1 + sub2 + sub3 + sub4 + sub5

// --- TODO 16: Aplicar descuentos ---

var porcentajeDescuento = 0.0

if subtotalGeneral >= 5000 {
    porcentajeDescuento = 0.15
} else if subtotalGeneral >= 2000 {
    porcentajeDescuento = 0.10
} else if subtotalGeneral >= 500 {
    porcentajeDescuento = 0.05
}

let descuento = subtotalGeneral * porcentajeDescuento
let subtotalConDescuento = subtotalGeneral - descuento

// --- TODO 17: Categorizar cliente con switch ---

let montoParaCategoria = Int(subtotalGeneral)
var categoriaCliente = ""

switch montoParaCategoria {
case 0..<500:
    categoriaCliente = "Regular"
case 500..<2000:
    categoriaCliente = "Frecuente"
case 2000..<5000:
    categoriaCliente = "VIP"
default:
    categoriaCliente = "Premium"
}

// --- TODO 18: Calcular IGV y total ---

let igvCarrito = subtotalConDescuento * 0.18
let totalFinal = subtotalConDescuento + igvCarrito

// --- TODO 19: Imprimir ticket ---

var separador = ""

for _ in 1...40 {
    separador += "="
}

print(separador)
print(" TICKET DE COMPRA")
print(" Cliente: \(categoriaCliente)")
print(separador)

print("\(prod1) x\(cant1) S/. \(sub1)")
print("\(prod2) x\(cant2) S/. \(sub2)")
print("\(prod3) x\(cant3) S/. \(sub3)")
print("\(prod4) x\(cant4) S/. \(sub4)")
print("\(prod5) x\(cant5) S/. \(sub5)")

print(separador)
print("Subtotal: S/. \(subtotalGeneral)")
print("Descuento (\(porcentajeDescuento * 100)%): -S/. \(descuento)")
print("Subtotal c/desc: S/. \(subtotalConDescuento)")
print("IGV (18%): S/. \(igvCarrito)")
print(separador)
print("TOTAL: S/. \(totalFinal)")
print(separador)
print("¡Gracias por su compra!")
// ===== EJERCICIO 6: CARRITO MEJORADO =====

// Producto 1 del carrito.
let producto1 = "Laptop"

// Precio unitario del producto 1.
let precioProducto1 = 3500.0

// Cantidad comprada del producto 1.
let cantidadProducto1 = 1

// Producto 2 del carrito.
let producto2 = "Mouse"

// Precio unitario del producto 2.
let precioProducto2 = 45.50

// Cantidad comprada del producto 2.
let cantidadProducto2 = 3

// Producto 3 del carrito.
let producto3 = "USB Cable"

// Precio unitario del producto 3.
let precioProducto3 = 15.0

// Cantidad comprada del producto 3.
let cantidadProducto3 = 4

// Código del cupón utilizado.
let cupon = "DESCUENTO20"

// Validamos que los precios no sean negativos.
let preciosValidos = precioProducto1 >= 0 && precioProducto2 >= 0 && precioProducto3 >= 0

// Validamos que las cantidades sean mayores que cero.
let cantidadesValidas = cantidadProducto1 > 0 && cantidadProducto2 > 0 && cantidadProducto3 > 0

// Verificamos que todos los datos del carrito sean válidos.
if preciosValidos && cantidadesValidas {

    // Calculamos el subtotal del producto 1.
    var subtotal1 = precioProducto1 * Double(cantidadProducto1)

    // Calculamos el subtotal del producto 2.
    var subtotal2 = precioProducto2 * Double(cantidadProducto2)

    // Calculamos el subtotal del producto 3.
    var subtotal3 = precioProducto3 * Double(cantidadProducto3)

    // Aplicamos 5% adicional de descuento al producto 2 porque tiene 3 unidades.
    if cantidadProducto2 >= 3 {
        subtotal2 = subtotal2 * 0.95
    }

    // Aplicamos 5% adicional de descuento al producto 3 porque tiene 3 o más unidades.
    if cantidadProducto3 >= 3 {
        subtotal3 = subtotal3 * 0.95
    }

    // Sumamos los subtotales para obtener el total inicial.
    let subtotal = subtotal1 + subtotal2 + subtotal3

    // Inicializamos el descuento del cupón en cero.
    var descuentoCupon = 0.0

    // Verificamos si el cupón ingresado es válido.
    if cupon == "DESCUENTO20" {
        descuentoCupon = subtotal * 0.20
    }

    // Calculamos el total después del descuento del cupón.
    let totalConDescuento = subtotal - descuentoCupon

    // Inicializamos el costo del envío.
    var costoEnvio = 25.0

    // Si el total supera S/. 3000, el envío es gratis.
    if totalConDescuento > 3000 {
        costoEnvio = 0.0
    }

    // Calculamos los puntos de fidelidad obtenidos.
    let puntos = Int(totalConDescuento / 100)

    // Calculamos el total final incluyendo el envío.
    let totalFinalMejorado = totalConDescuento + costoEnvio

    // Mostramos una línea separadora.
    print("========================================")

    // Mostramos el título del ticket.
    print("       CARRITO MEJORADO")

    // Mostramos otra línea separadora.
    print("========================================")

    // Mostramos el primer producto.
    print("\(producto1): S/. \(subtotal1)")

    // Mostramos el segundo producto.
    print("\(producto2): S/. \(subtotal2)")

    // Mostramos el tercer producto.
    print("\(producto3): S/. \(subtotal3)")

    // Mostramos el subtotal.
    print("Subtotal: S/. \(subtotal)")

    // Mostramos el descuento aplicado por cupón.
    print("Descuento cupón: S/. \(descuentoCupon)")

    // Mostramos el costo del envío.
    print("Envío: S/. \(costoEnvio)")

    // Mostramos los puntos ganados.
    print("Puntos ganados: \(puntos)")

    // Mostramos el total final.
    print("TOTAL: S/. \(totalFinalMejorado)")

    // Cerramos el ticket.
    print("========================================")

} else {

    // Mostramos un mensaje cuando algún dato del carrito es inválido.
    print("ERROR: Precio negativo o cantidad inválida.")
}
