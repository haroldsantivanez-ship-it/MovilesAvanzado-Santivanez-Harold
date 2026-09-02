// Importa Foundation para utilizar funcionalidades básicas de Swift.
import Foundation

// Define el precio de una Laptop.
let precioLaptop = 3500.00

// Define la cantidad de Laptops compradas.
let cantidadLaptop = 3

// Define el código del cupón utilizado por el cliente.
let cupon = "DESCUENTO20"

// Verifica que el precio no sea negativo y que la cantidad no sea cero.
if precioLaptop < 0 || cantidadLaptop == 0 {
    // Muestra un mensaje de error si los datos no son válidos.
    print("Error: el precio no puede ser negativo y la cantidad no puede ser 0.")
} else {
    // Calcula el subtotal multiplicando el precio por la cantidad.
    let subtotal = precioLaptop * Double(cantidadLaptop)

    // Inicializa el descuento por cantidad en cero.
    var descuentoCantidad = 0.0

    // Verifica si se compraron 3 o más unidades del mismo producto.
    if cantidadLaptop >= 3 {
        // Calcula un descuento adicional del 5% sobre el subtotal.
        descuentoCantidad = subtotal * 0.05
    }

    // Calcula el monto después de aplicar el descuento por cantidad.
    let totalConDescuentoCantidad = subtotal - descuentoCantidad

    // Inicializa el descuento del cupón en cero.
    var descuentoCupon = 0.0

    // Comprueba si el código ingresado coincide con el cupón válido.
    if cupon == "DESCUENTO20" {
        // Calcula un descuento adicional del 20% sobre el total anterior.
        descuentoCupon = totalConDescuentoCantidad * 0.20
    }

    // Calcula el total después de aplicar el cupón.
    let totalConDescuentos = totalConDescuentoCantidad - descuentoCupon

    // Inicializa el costo de envío en cero.
    var costoEnvio = 0.0

    // Verifica si el total supera los S/. 3000.
    if totalConDescuentos > 3000 {
        // Mantiene el envío gratis cuando se supera el monto establecido.
        costoEnvio = 0.0
    } else {
        // Establece el costo de envío en S/. 25 cuando no se supera el monto.
        costoEnvio = 25.00
    }

    // Calcula el total final incluyendo el costo de envío.
    let totalFinal = totalConDescuentos + costoEnvio

    // Calcula un punto de fidelidad por cada S/. 100 de compra.
    let puntosFidelidad = Int(totalFinal / 100)

    // Muestra el subtotal de la compra.
    print("Subtotal: S/. \(subtotal)")

    // Muestra el descuento aplicado por cantidad.
    print("Descuento por cantidad: S/. \(descuentoCantidad)")

    // Muestra el descuento aplicado por el cupón.
    print("Descuento por cupón: S/. \(descuentoCupon)")

    // Muestra el costo de envío.
    print("Costo de envío: S/. \(costoEnvio)")

    // Muestra el total final de la compra.
    print("Total final: S/. \(totalFinal)")

    // Muestra los puntos de fidelidad obtenidos.
    print("Puntos de fidelidad: \(puntosFidelidad)")
}
