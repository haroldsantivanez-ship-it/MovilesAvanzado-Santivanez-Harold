import Foundation

struct Cliente {
    var apellidos: String
    var nombres: String
    var dni: String
}

struct Venta {
    var electrodomestico: String
    var precioUnitario: Double
    var cantidad: Int
    var meses: Int
    var interesMensual: Double
}

struct ResultadoVenta {
    var subtotal: Double
    var igv: Double
    var base: Double
    var intereses: Double
    var total: Double
    var cuotaMensual: Double
}
