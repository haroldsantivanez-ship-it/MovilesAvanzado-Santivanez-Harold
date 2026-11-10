import SwiftUI
import SwiftData

@main
struct ComprasApp: App {
    // Una sola sesión para toda la app
    @State private var sesion = Sesion()

    // Contenedor con las 4 clases @Model
    let contenedor: ModelContainer = {
        let schema = Schema([Usuario.self, Proveedor.self, Producto.self, Compra.self])
        let config = ModelConfiguration("ComprasData", schema: schema)
        do {
            let contenedor = try ModelContainer(for: schema, configurations: [config])
            print("Base de datos SQLite en: \(config.url.path)")
            return contenedor
        } catch {
            fatalError("Error al crear el ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(sesion)          // la sesión llega a todas las vistas
        }
        .modelContainer(contenedor)           // el contexto llega a todas las vistas
    }
}

/// Pantalla inicial: si hay usuario → pestañas de su rol; si no → login.
struct RootView: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        if let usuario = sesion.usuario {
            if usuario.esSupervisor {
                SupervisorTabView()
            } else {
                CompradorTabView()
            }
        } else {
            LoginView()
        }
    }
}

// MARK: - Pestañas del Comprador: Productos, Proveedores, Compra, Mis compras

struct CompradorTabView: View {
    var body: some View {
        TabView {
            ProductosView()
                .tabItem { Label("Productos", systemImage: "shippingbox") }
            ProveedoresView()
                .tabItem { Label("Proveedores", systemImage: "building.2") }
            NuevaCompraView()
                .tabItem { Label("Compra", systemImage: "cart.badge.plus") }
            MisComprasView()
                .tabItem { Label("Mis compras", systemImage: "list.bullet.rectangle") }
        }
    }
}

// MARK: - Pestañas del Supervisor: Resumen, Aprobar, Por pagar, Productos, Proveedores

struct SupervisorTabView: View {
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" }) private var pendientes: [Compra]

    var body: some View {
        TabView {
            ResumenView()
                .tabItem { Label("Resumen", systemImage: "chart.bar.xaxis") }
            AprobarView()
                .tabItem { Label("Aprobar", systemImage: "checkmark.seal") }
                .badge(pendientes.count)
            PorPagarView()
                .tabItem { Label("Por pagar", systemImage: "creditcard") }
            ProductosView()
                .tabItem { Label("Productos", systemImage: "shippingbox") }
            ProveedoresView()
                .tabItem { Label("Proveedores", systemImage: "building.2") }
        }
    }
}
