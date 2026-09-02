import Foundation

// MARK: - Datos de la compra

let nombreProducto = "Laptop Lenovo"
let precioUnitario = 3500.0
let cantidadComprada = 2

// MARK: - Cálculo de compra

let importeCompra = precioUnitario * Double(cantidadComprada)

// Se aplica un beneficio del 20% cuando la compra
// alcanza las 2 unidades.
let porcentajeBeneficio: Double

if cantidadComprada >= 2 {
    porcentajeBeneficio = 0.20
} else {
    porcentajeBeneficio = 0.0
}

let beneficio = importeCompra * porcentajeBeneficio
let montoCompra = importeCompra - beneficio

// MARK: - Selección del plan

let planElegido = 6

var tasaInteres: Double

switch planElegido {
case 6:
    tasaInteres = 0.05
case 12:
    tasaInteres = 0.10
case 24:
    tasaInteres = 0.18
default:
    tasaInteres = 0.0
}

let interesGenerado = montoCompra * tasaInteres
let montoFinanciado = montoCompra + interesGenerado
let cuotaMensual = montoFinanciado / Double(planElegido)

// MARK: - Resumen

print("========== RESUMEN DE COMPRA ==========")
print("Producto: \(nombreProducto)")
print("Precio unitario: S/. \(precioUnitario)")
print("Cantidad: \(cantidadComprada)")
print("Importe de compra: S/. \(importeCompra)")
print("Beneficio aplicado: S/. \(beneficio)")
print("Monto de compra: S/. \(montoCompra)")

print("")
print("========== PLAN DE PAGO ==========")
print("Plan elegido: \(planElegido) meses")
print("Interés aplicado: \(tasaInteres * 100)%")
print("Interés generado: S/. \(interesGenerado)")
print("Monto financiado: S/. \(montoFinanciado)")
print("Cuota mensual: S/. \(cuotaMensual)")

print("")
print("Mes | Monto inicial | Cuota mensual | Resta por pagar")
print("------------------------------------------------------")

// MARK: - Calendario de pagos

var saldoPendiente = montoFinanciado

for mes in 1...planElegido {
    let montoInicial = saldoPendiente
    
    saldoPendiente -= cuotaMensual
    
    if saldoPendiente < 0 {
        saldoPendiente = 0
    }
    
    print("\(mes) | S/. \(montoInicial) | S/. \(cuotaMensual) | S/. \(saldoPendiente)")
}
