import Foundation

class VentaModel: Calculable, Validable {

    var precio: Double
    var cantidad: Int
    var meses: Int
    var interesMensual: Double

    private let servicio = VentaService()

    init(precio: Double, cantidad: Int, meses: Int, interesMensual: Double) {
        self.precio = precio
        self.cantidad = cantidad
        self.meses = meses
        self.interesMensual = interesMensual
    }

    func validar() -> Bool {
        return precio > 0 &&
               cantidad > 0 &&
               meses > 0 &&
               interesMensual >= 0
    }

    func calcular() -> ResultadoVenta {
        return servicio.calcularVenta(
            precio: precio,
            cantidad: cantidad,
            meses: meses,
            interesMensual: interesMensual
        )
    }
}
