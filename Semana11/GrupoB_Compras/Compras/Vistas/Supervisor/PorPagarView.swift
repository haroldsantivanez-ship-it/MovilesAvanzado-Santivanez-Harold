import SwiftUI
import SwiftData

/// B8 · ① Segmented Pendientes / Vencidas / Pagadas · ② Compra a crédito pendiente ·
/// ③ Etiqueta VENCIDA · ④ Deslizar Pagar (solo supervisor) · ⑤ Total por pagar
struct PorPagarView: View {
    enum Filtro: String, CaseIterable {
        case pendientes = "Pendientes", vencidas = "Vencidas", pagadas = "Pagadas"
    }

    @State private var filtro: Filtro = .pendientes
    @State private var busqueda = ""

    // ⑤ Todas las cuentas por pagar (aprobadas, al crédito, sin pagar)
    @Query(filter: #Predicate<Compra> {
        $0.estado == "Aprobada" && $0.alCredito == true && $0.pagada == false
    }) private var deudas: [Compra]

    private var totalPorPagar: Double { deudas.reduce(0) { $0 + $1.total } }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Filtro", selection: $filtro) {                              // ①
                    ForEach(Filtro.allCases, id: \.self) { Text($0.rawValue) }
                }
                .pickerStyle(.segmented)
                .padding()

                // Subvista con @Query dinámica: se recrea cuando cambia el filtro
                ListaPorPagar(filtro: filtro, busqueda: busqueda)

                // ⑤ Total por pagar
                HStack {
                    Text("Total por pagar").font(.headline)
                    Spacer()
                    Text(totalPorPagar.soles).font(.title3.bold()).monospacedDigit()
                }
                .padding()
                .background(.bar)
            }
            .searchable(text: $busqueda, prompt: "Buscar por proveedor")
            .navigationTitle("Por pagar")
            .conAvatar()
        }
    }
}

/// Nivel +: el filtro se hace con #Predicate en la consulta (no filtrando el arreglo).
struct ListaPorPagar: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var compras: [Compra]
    private let busqueda: String
    private let filtro: PorPagarView.Filtro

    init(filtro: PorPagarView.Filtro, busqueda: String) {
        self.filtro = filtro
        self.busqueda = busqueda
        let aprobada = EstadoCompra.aprobada   // valores en let antes del #Predicate
        let ahora = Date.now

        let predicado: Predicate<Compra>
        switch filtro {
        case .pendientes:   // todas las no pagadas (incluye las vencidas, marcadas en rojo)
            predicado = #Predicate { $0.estado == aprobada && $0.alCredito == true && $0.pagada == false }
        case .vencidas:
            predicado = #Predicate { $0.estado == aprobada && $0.alCredito == true && $0.pagada == false && $0.vence < ahora }
        case .pagadas:
            predicado = #Predicate { $0.estado == aprobada && $0.alCredito == true && $0.pagada == true }
        }
        _compras = Query(filter: predicado, sort: \Compra.vence)
    }

    // Búsqueda por proveedor sobre el resultado de la consulta
    private var visibles: [Compra] {
        guard !busqueda.isEmpty else { return compras }
        return compras.filter { $0.proveedor?.nombre.localizedCaseInsensitiveContains(busqueda) ?? false }
    }

    var body: some View {
        List {
            ForEach(visibles) { compra in
                FilaPorPagar(compra: compra)
                    .swipeActions(edge: .trailing) {                                // ④
                        if !compra.pagada {
                            Button("Pagar", systemImage: "banknote") {
                                withAnimation { ReglasCompra.pagar(compra, en: modelContext) }
                            }
                            .tint(.green)
                        }
                    }
            }
        }
        .listStyle(.plain)
        .overlay {
            if visibles.isEmpty {
                ContentUnavailableView("Sin compras", systemImage: "creditcard",
                                       description: Text("No hay compras en \(filtro.rawValue.lowercased())"))
            }
        }
    }
}

struct FilaPorPagar: View {
    let compra: Compra

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(compra.proveedor?.nombre ?? "-").font(.headline)
                Spacer()
                if compra.estaVencida {
                    Insignia(texto: "VENCIDA", color: .red)                         // ③
                } else if compra.pagada {
                    Insignia(texto: "Pagada", color: .green)
                } else {
                    Insignia(texto: "Pendiente", color: .orange)                     // ②
                }
            }
            Text("\(compra.producto?.nombre ?? "-") · \(compra.cantidad) und · \(compra.comprador?.nombre ?? "-")")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            HStack {
                Text("Vence: \(compra.vence.corta)")
                    .foregroundStyle(compra.estaVencida ? .red : .secondary)
                Spacer()
                Text(compra.total.soles).bold().monospacedDigit()
            }
            .font(.caption)
        }
        .padding(.vertical, 2)
    }
}
