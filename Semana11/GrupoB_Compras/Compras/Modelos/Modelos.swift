import Foundation
import SwiftData

// MARK: - Constantes de texto (evitan errores de tipeo en rol y estado)

enum Rol {
    static let comprador = "Comprador"
    static let supervisor = "Supervisor"
}

enum EstadoCompra {
    static let pendiente = "Pendiente"
    static let aprobada = "Aprobada"
    static let rechazada = "Rechazada"
}

// MARK: - Usuario

@Model
final class Usuario {
    var nombre: String
    var usuario: String          // se guarda en minúsculas → único sin distinguir mayúsculas
    var clave: String            // texto plano SOLO por ser práctica (ver nota del laboratorio)
    var rol: String              // "Comprador" o "Supervisor"

    // Lado "muchos": un usuario registra muchas compras.
    // .deny → no se puede borrar un usuario que tenga compras.
    @Relationship(deleteRule: .deny, inverse: \Compra.comprador)
    var compras: [Compra] = []

    init(nombre: String, usuario: String, clave: String, rol: String) {
        self.nombre = nombre
        self.usuario = usuario
        self.clave = clave
        self.rol = rol
    }

    var esSupervisor: Bool { rol == Rol.supervisor }

    /// Iniciales para el avatar ("Harold Santivañez" → "HS")
    var iniciales: String {
        nombre.split(separator: " ").prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased()
    }
}

// MARK: - Proveedor

@Model
final class Proveedor {
    var nombre: String
    var ruc: String

    @Relationship(deleteRule: .deny, inverse: \Compra.proveedor)
    var compras: [Compra] = []

    init(nombre: String, ruc: String) {
        self.nombre = nombre
        self.ruc = ruc
    }

    /// Total comprado: solo compras aprobadas (las pendientes o rechazadas no cuentan)
    var totalComprado: Double {
        compras.filter { $0.estado == EstadoCompra.aprobada }.reduce(0) { $0 + $1.total }
    }

    /// Deuda con el proveedor: compras aprobadas al crédito y sin pagar
    var porPagar: Double {
        compras.filter { $0.estaPorPagar }.reduce(0) { $0 + $1.total }
    }
}

// MARK: - Producto

@Model
final class Producto {
    var nombre: String
    var categoria: String
    var stock: Int
    var costoPromedio: Double

    @Relationship(deleteRule: .deny, inverse: \Compra.producto)
    var compras: [Compra] = []

    init(nombre: String, categoria: String, stock: Int, costoPromedio: Double) {
        self.nombre = nombre
        self.categoria = categoria
        self.stock = stock
        self.costoPromedio = costoPromedio
    }

    /// Valor del inventario de este producto = stock × costo promedio
    var valorInventario: Double { Double(stock) * costoPromedio }
}

// MARK: - Compra

@Model
final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String            // Pendiente, Aprobada o Rechazada
    var pagada: Bool
    var motivoRechazo: String?

    // Lado "uno" de cada relación (el inverso está declarado en la otra clase)
    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?

    init(fecha: Date = .now, cantidad: Int, costoUnitario: Double, igv: Double, total: Double,
         alCredito: Bool, vence: Date, estado: String, pagada: Bool,
         comprador: Usuario?, proveedor: Proveedor?, producto: Producto?) {
        self.fecha = fecha
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.igv = igv
        self.total = total
        self.alCredito = alCredito
        self.vence = vence
        self.estado = estado
        self.pagada = pagada
        self.comprador = comprador
        self.proveedor = proveedor
        self.producto = producto
    }

    var subtotal: Double { Double(cantidad) * costoUnitario }

    /// Cuenta por pagar: aprobada, al crédito y aún no pagada
    var estaPorPagar: Bool { estado == EstadoCompra.aprobada && alCredito && !pagada }

    /// VENCIDA: por pagar y con fecha de vencimiento ya pasada
    var estaVencida: Bool { estaPorPagar && vence < .now }
}
