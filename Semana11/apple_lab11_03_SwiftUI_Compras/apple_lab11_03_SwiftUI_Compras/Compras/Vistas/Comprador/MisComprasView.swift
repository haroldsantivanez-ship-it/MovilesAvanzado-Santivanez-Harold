import SwiftUI
import SwiftData

/// B6 · ① Segmented Todas / Pendientes / Rechazadas · ② Pendiente de aprobación ·
/// ③ Rechazada con su motivo · ④ El comprador solo ve las suyas
struct MisComprasView: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        NavigationStack {
            // ④ Solo las suyas: usamos la relación inversa usuario.compras
            ComprasListaView(compras: sesion.usuario?.compras ?? [], mostrarComprador: false)
                .navigationTitle("Mis compras")
                .conAvatar()
        }
    }
}

/// Lista reutilizable: el comprador le pasa sus compras y el supervisor todas.
struct ComprasListaView: View {
    let compras: [Compra]
    var mostrarComprador = true

    enum Filtro: String, CaseIterable {
        case todas = "Todas", pendientes = "Pendientes", rechazadas = "Rechazadas"
    }

    @State private var filtro: Filtro = .todas
    @State private var busqueda = ""

    private var filtradas: [Compra] {
        compras
            .filter {
                switch filtro {
                case .todas:      return true
                case .pendientes: return $0.estado == EstadoCompra.pendiente
                case .rechazadas: return $0.estado == EstadoCompra.rechazada
                }
            }
            .filter { busqueda.isEmpty || ($0.proveedor?.nombre.localizedCaseInsensitiveContains(busqueda) ?? false) }
            .sorted { $0.fecha > $1.fecha }
    }

    var body: some View {
        List {
            Picker("Filtro", selection: $filtro) {                         // ①
                ForEach(Filtro.allCases, id: \.self) { Text($0.rawValue) }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)

            ForEach(filtradas) { compra in
                FilaCompra(compra: compra, mostrarComprador: mostrarComprador)
            }
        }
        .searchable(text: $busqueda, prompt: "Buscar por proveedor")
        .overlay {
            if filtradas.isEmpty {
                ContentUnavailableView("Sin compras", systemImage: "cart",
                                       description: Text("No hay compras en este filtro"))
            }
        }
    }
}

struct FilaCompra: View {
    let compra: Compra
    var mostrarComprador = true

    private var colorEstado: Color {
        switch compra.estado {
        case EstadoCompra.aprobada:  return .green
        case EstadoCompra.rechazada: return .red
        default:                     return .orange
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(compra.producto?.nombre ?? "Producto eliminado").font(.headline)
                Spacer()
                Insignia(texto: compra.estado, color: colorEstado)              // ②
            }
            Text("\(compra.proveedor?.nombre ?? "-") · \(compra.cantidad) × \(compra.costoUnitario.soles)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            HStack {
                Text(compra.fecha.corta)
                Text(compra.alCredito ? "Crédito" : "Contado")
                if mostrarComprador, let comprador = compra.comprador {
                    Text("· \(comprador.nombre)")
                }
                Spacer()
                Text(compra.total.soles).bold().monospacedDigit()
            }
            .font(.caption)
            if compra.estado == EstadoCompra.rechazada, let motivo = compra.motivoRechazo {   // ③
                Label("Motivo: \(motivo)", systemImage: "text.bubble")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 2)
    }
}

/// Supervisor: ver TODAS las compras (se abre desde la pestaña Aprobar)
struct TodasLasComprasView: View {
    @Query(sort: \Compra.fecha, order: .reverse) private var compras: [Compra]

    var body: some View {
        ComprasListaView(compras: compras, mostrarComprador: true)
            .navigationTitle("Todas las compras")
    }
}
