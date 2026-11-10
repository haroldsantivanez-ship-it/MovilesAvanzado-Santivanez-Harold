import Foundation
import SwiftData

/// Reglas de negocio del caso Compras, separadas de las vistas
/// para poder explicarlas y probarlas con los casos del laboratorio.
enum ReglasCompra {

    static let tasaIGV = 0.18
    static let montoAprobacion = 5_000.0     // desde S/ 5,000 requiere aprobación
    static let diasCredito = 30

    struct Montos {
        let subtotal: Double
        let igv: Double
        let total: Double
    }

    /// IGV 18 % sobre el subtotal. Total = subtotal + IGV.
    /// Caso 3: 10 × 120.00 → subtotal 1,200.00 · IGV 216.00 · total 1,416.00
    static func calcular(cantidad: Int, costoUnitario: Double) -> Montos {
        let subtotal = Double(cantidad) * costoUnitario
        let igv = redondear(subtotal * tasaIGV)
        return Montos(subtotal: subtotal, igv: igv, total: redondear(subtotal + igv))
    }

    static func requiereAprobacion(total: Double) -> Bool {
        total >= montoAprobacion
    }

    /// Costo promedio ponderado:
    /// (stock × costoProm + cantidad × costoUnit) / (stock + cantidad)
    /// Caso 3: (40 × 110 + 10 × 120) / 50 = 112.00
    /// Caso 6: (40 × 110 + 50 × 120) / 90 = 115.56
    static func nuevoCostoPromedio(stock: Int, costoPromedio: Double,
                                   cantidad: Int, costoUnitario: Double) -> Double {
        let unidades = stock + cantidad
        guard unidades > 0 else { return costoUnitario }
        let valor = Double(stock) * costoPromedio + Double(cantidad) * costoUnitario
        return valor / Double(unidades)
    }

    /// Crea la compra aplicando las reglas. Si es menor a S/ 5,000 queda Aprobada
    /// y aplica los efectos al instante; si no, queda Pendiente sin tocar nada.
    @discardableResult
    static func registrar(cantidad: Int, costoUnitario: Double, alCredito: Bool,
                          comprador: Usuario, proveedor: Proveedor, producto: Producto,
                          en contexto: ModelContext) -> Compra {
        let montos = calcular(cantidad: cantidad, costoUnitario: costoUnitario)
        let hoy = Date.now
        let vence = alCredito
            ? Calendar.current.date(byAdding: .day, value: diasCredito, to: hoy)!
            : hoy

        let compra = Compra(
            fecha: hoy,
            cantidad: cantidad,
            costoUnitario: costoUnitario,
            igv: montos.igv,
            total: montos.total,
            alCredito: alCredito,
            vence: vence,
            estado: requiereAprobacion(total: montos.total) ? EstadoCompra.pendiente : EstadoCompra.aprobada,
            pagada: !alCredito,                // contado → ya pagada
            comprador: comprador,
            proveedor: proveedor,
            producto: producto
        )
        contexto.insert(compra)

        if compra.estado == EstadoCompra.aprobada {
            aplicarEfectos(de: compra)
        }
        try? contexto.save()
        return compra
    }

    /// Efectos de una compra aprobada: sube el stock y recalcula el costo promedio.
    /// (Las cuentas por pagar salen solas porque se calculan desde las compras aprobadas.)
    static func aplicarEfectos(de compra: Compra) {
        guard let producto = compra.producto else { return }
        producto.costoPromedio = nuevoCostoPromedio(
            stock: producto.stock, costoPromedio: producto.costoPromedio,
            cantidad: compra.cantidad, costoUnitario: compra.costoUnitario)
        producto.stock += compra.cantidad
    }

    static func aprobar(_ compra: Compra, en contexto: ModelContext) {
        guard compra.estado == EstadoCompra.pendiente else { return }
        compra.estado = EstadoCompra.aprobada
        aplicarEfectos(de: compra)
        try? contexto.save()
    }

    /// Rechazar exige motivo y NO cambia stock ni costo.
    /// Devuelve false si el motivo está vacío.
    @discardableResult
    static func rechazar(_ compra: Compra, motivo: String, en contexto: ModelContext) -> Bool {
        let texto = motivo.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !texto.isEmpty, compra.estado == EstadoCompra.pendiente else { return false }
        compra.estado = EstadoCompra.rechazada
        compra.motivoRechazo = texto
        try? contexto.save()
        return true
    }

    static func pagar(_ compra: Compra, en contexto: ModelContext) {
        compra.pagada = true
        try? contexto.save()
    }

    private static func redondear(_ valor: Double) -> Double {
        (valor * 100).rounded() / 100
    }
}
