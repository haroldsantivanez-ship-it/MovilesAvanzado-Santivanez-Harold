import Foundation
import SwiftData

/// Datos de prueba para ejecutar los 9 casos rápidamente.
/// Se cargan desde el botón "Cargar datos de prueba" del login (solo si no hay productos).
/// Devuelve un mensaje para mostrarlo en pantalla.
enum DatosDemo {

    @discardableResult
    static func cargar(en contexto: ModelContext) -> String {
        let cantidadProductos = (try? contexto.fetchCount(FetchDescriptor<Producto>())) ?? 0
        guard cantidadProductos == 0 else {
            print("DATOS DEMO: ya hay \(cantidadProductos) productos, no se cargó nada")
            return "Ya hay \(cantidadProductos) productos cargados."
        }

        // 1) Usuarios (clave 123456). Si ya existen, se reutilizan.
        _ = buscarOCrear("supervisor", nombre: "Lucia Paredes", rol: Rol.supervisor, en: contexto)
        let comprador = buscarOCrear("comprador", nombre: "Carlos Rojas", rol: Rol.comprador, en: contexto)

        // 2) Proveedores
        let techPeru = Proveedor(nombre: "Tech Perú SAC", ruc: "20512345678")
        let andina = Proveedor(nombre: "Distribuidora Andina EIRL", ruc: "20487654321")
        let lima = Proveedor(nombre: "Importaciones Lima SA", ruc: "20601122334")
        contexto.insert(techPeru)
        contexto.insert(andina)
        contexto.insert(lima)

        // 3) Productos — el Monitor es el del caso 3 (stock 40, costo promedio 110.00)
        let monitor = Producto(nombre: "Monitor 24\"", categoria: "Cómputo", stock: 40, costoPromedio: 110)
        let teclado = Producto(nombre: "Teclado mecánico", categoria: "Accesorios", stock: 8, costoPromedio: 85)
        let mouse = Producto(nombre: "Mouse inalámbrico", categoria: "Accesorios", stock: 4, costoPromedio: 25)
        let impresora = Producto(nombre: "Impresora láser", categoria: "Oficina", stock: 15, costoPromedio: 420)
        contexto.insert(monitor)
        contexto.insert(teclado)
        contexto.insert(mouse)
        contexto.insert(impresora)

        // Guardamos primero lo básico
        do {
            try contexto.save()
        } catch {
            print("DATOS DEMO: error al guardar productos/proveedores: \(error)")
            return "Error al cargar: \(error.localizedDescription)"
        }

        // 4) Caso 8: compra a crédito ya VENCIDA (hace 40 días, venció hace 10).
        //    Primero se inserta la compra sin relaciones y LUEGO se enlaza.
        let hace40 = Calendar.current.date(byAdding: .day, value: -40, to: .now)!
        let hace10 = Calendar.current.date(byAdding: .day, value: -10, to: .now)!
        let montos = ReglasCompra.calcular(cantidad: 5, costoUnitario: 85)
        let vencida = Compra(fecha: hace40, cantidad: 5, costoUnitario: 85, igv: montos.igv, total: montos.total,
                             alCredito: true, vence: hace10, estado: EstadoCompra.aprobada, pagada: false,
                             comprador: nil, proveedor: nil, producto: nil)
        contexto.insert(vencida)
        vencida.comprador = comprador
        vencida.proveedor = andina
        vencida.producto = teclado

        do {
            try contexto.save()
        } catch {
            print("DATOS DEMO: error al guardar la compra vencida: \(error)")
        }

        print("DATOS DEMO: cargados 4 productos, 3 proveedores y 1 compra vencida")
        return "Datos de prueba cargados ✔︎"
    }

    private static func buscarOCrear(_ usuario: String, nombre: String, rol: String,
                                     en contexto: ModelContext) -> Usuario {
        let buscado = usuario
        let descriptor = FetchDescriptor<Usuario>(predicate: #Predicate { $0.usuario == buscado })
        if let existente = try? contexto.fetch(descriptor).first { return existente }
        let nuevo = Usuario(nombre: nombre, usuario: usuario, clave: "123456", rol: rol)
        contexto.insert(nuevo)
        return nuevo
    }
}
