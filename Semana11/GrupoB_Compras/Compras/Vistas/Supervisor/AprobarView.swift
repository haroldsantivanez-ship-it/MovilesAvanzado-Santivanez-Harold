import SwiftUI
import SwiftData

/// B7 · ① Avatar · ② Tarjeta de la compra pendiente con quién la solicitó ·
/// ③ Vista previa: stock y costo promedio antes y después · ④ Rechazar (pide motivo) o Aprobar
struct AprobarView: View {
    @Environment(\.modelContext) private var modelContext

    // Solo compras Pendientes (#Predicate)
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" },
           sort: \Compra.fecha) private var pendientes: [Compra]

    @State private var compraRechazar: Compra?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(pendientes) { compra in
                        TarjetaAprobacion(
                            compra: compra,
                            aprobar: { ReglasCompra.aprobar(compra, en: modelContext) },
                            rechazar: { compraRechazar = compra })
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Aprobar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink("Ver todas") { TodasLasComprasView() }
                }
            }
            .conAvatar()                                                    // ①
            .overlay {
                if pendientes.isEmpty {
                    ContentUnavailableView("Nada por aprobar", systemImage: "checkmark.seal",
                                           description: Text("Las compras desde S/ 5,000 aparecerán aquí"))
                }
            }
            .sheet(item: $compraRechazar) { RechazoView(compra: $0) }
        }
    }
}

struct TarjetaAprobacion: View {
    let compra: Compra
    let aprobar: () -> Void
    let rechazar: () -> Void

    var body: some View {
        let producto = compra.producto
        let stockAntes = producto?.stock ?? 0
        let costoAntes = producto?.costoPromedio ?? 0
        let costoDespues = ReglasCompra.nuevoCostoPromedio(stock: stockAntes, costoPromedio: costoAntes,
                                                           cantidad: compra.cantidad, costoUnitario: compra.costoUnitario)

        VStack(alignment: .leading, spacing: 12) {
            // ② Datos y solicitante
            HStack {
                VStack(alignment: .leading) {
                    Text(producto?.nombre ?? "-").font(.headline)
                    Text(compra.proveedor?.nombre ?? "-").font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Text(compra.total.soles).font(.title3.bold()).monospacedDigit()
            }
            Text("Solicitado por \(compra.comprador?.nombre ?? "-") · \(compra.fecha.corta)")
                .font(.caption)
            Text("\(compra.cantidad) × \(compra.costoUnitario.soles) · IGV \(compra.igv.soles) · \(compra.alCredito ? "Crédito 30 días" : "Contado")")
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()

            // ③ Efecto si se aprueba
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 6) {
                GridRow {
                    Text("").gridColumnAlignment(.leading)
                    Text("Antes").foregroundStyle(.secondary)
                    Text("Después").foregroundStyle(.secondary)
                }
                GridRow {
                    Text("Stock")
                    Text("\(stockAntes)")
                    Text("\(stockAntes + compra.cantidad)").bold()
                }
                GridRow {
                    Text("Costo prom.")
                    Text(costoAntes.dosDecimales)
                    Text(costoDespues.dosDecimales).bold()
                }
            }
            .font(.subheadline.monospacedDigit())

            // ④ Acciones
            HStack {
                Button("Rechazar", role: .destructive, action: rechazar)
                    .buttonStyle(.bordered)
                Spacer()
                Button("Aprobar", action: aprobar)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }
}

/// Rechazo: el motivo es obligatorio (caso 7)
struct RechazoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let compra: Compra
    @State private var motivo = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Compra") {
                    LabeledContent("Producto", value: compra.producto?.nombre ?? "-")
                    LabeledContent("Total", value: compra.total.soles)
                    LabeledContent("Solicitante", value: compra.comprador?.nombre ?? "-")
                }
                Section {
                    TextField("Motivo del rechazo", text: $motivo, axis: .vertical)
                        .lineLimit(3...5)
                } header: {
                    Text("Motivo (obligatorio)")
                } footer: {
                    Text("Al rechazar no cambia el stock ni el costo promedio. El comprador verá este motivo.")
                }
            }
            .navigationTitle("Rechazar compra")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Rechazar", role: .destructive) {
                        if ReglasCompra.rechazar(compra, motivo: motivo, en: modelContext) { dismiss() }
                    }
                    .disabled(motivo.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
