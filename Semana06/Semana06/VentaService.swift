import Foundation

class VentaService {

    func calcularVenta(
        precio: Double,
        cantidad: Int,
        meses: Int,
        interesMensual: Double
    ) -> ResultadoVenta {

        let subtotal = precio * Double(cantidad)
        let igv = subtotal * 0.18
        let base = subtotal + igv

        let intereses = base * (interesMensual / 100) * Double(meses)
        let total = base + intereses

        let cuotaMensual = meses > 0
            ? total / Double(meses)
            : 0

        return ResultadoVenta(
            subtotal: subtotal,
            igv: igv,
            base: base,
            intereses: intereses,
            total: total,
            cuotaMensual: cuotaMensual
        )
    }
}
