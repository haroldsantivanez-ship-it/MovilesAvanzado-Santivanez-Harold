import Foundation

// MARK: - Datos de la compra

let nombreProducto = "Laptop Lenovo"
let precioUnitario = 3500.0
let cantidadComprada = 2

// MARK: - Cálculo del importe

let importeCompra = precioUnitario * Double(cantidadComprada)

// MARK: - Cálculo del beneficio

func calcularBeneficio(cantidad: Int, importe: Double) -> Double {
    if cantidad >= 2 {
        return importe * 0.20
    }
    
    return 0.0
}

let beneficio = calcularBeneficio(
    cantidad: cantidadComprada,
    importe: importeCompra
)

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

// MARK: - Cálculo del financiamiento

func calcularFinanciamiento(
    monto: Double,
    tasa: Double,
    meses: Int
) -> (interes: Double, financiado: Double, cuota: Double) {
    
    let interes = monto * tasa
    let financiado = monto + interes
    let cuota = financiado / Double(meses)
    
    return (interes, financiado, cuota)
}

let financiamiento = calcularFinanciamiento(
    monto: montoCompra,
    tasa: tasaInteres,
    meses: planElegido
)

let interesGenerado = financiamiento.interes
let montoFinanciado = financiamiento.financiado
let cuotaMensual = financiamiento.cuota

// MARK: - Resumen de la operación

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

// MARK: - Calendario de pagos

print("")
print("========== CALENDARIO DE PAGOS ==========")
print("Mes | Monto inicial | Cuota mensual | Saldo pendiente")
print("------------------------------------------------------")

var saldoPendiente = montoFinanciado

for mes in 1...planElegido {
    
    let montoInicial = saldoPendiente
    
    saldoPendiente -= cuotaMensual
    
    if saldoPendiente < 0 {
        saldoPendiente = 0
    }
    
    print(
        "\(mes) | S/. \(montoInicial) | S/. \(cuotaMensual) | S/. \(saldoPendiente)"
    )
}

print("------------------------------------------------------")
print("Compra financiada correctamente.")
