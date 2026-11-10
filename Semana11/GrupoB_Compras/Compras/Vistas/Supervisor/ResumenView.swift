import SwiftUI
import SwiftData
import Charts

/// B9 · ① Avatar · ② Valor del inventario · ③ Crédito fiscal (IGV) ·
/// ④ Compras por aprobar (cantidad e importe) · ⑤ Total comprado por proveedor con barras
struct ResumenView: View {
    @Environment(Sesion.self) private var sesion

    @Query private var productos: [Producto]
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(filter: #Predicate<Compra> { $0.estado == "Aprobada" }) private var aprobadas: [Compra]
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" }) private var pendientes: [Compra]

    private var valorInventario: Double { productos.reduce(0) { $0 + $1.valorInventario } }
    private var creditoFiscal: Double { aprobadas.reduce(0) { $0 + $1.igv } }
    private var porPagar: Double { aprobadas.filter(\.estaPorPagar).reduce(0) { $0 + $1.total } }
    private var vencidas: Int { aprobadas.filter(\.estaVencida).count }
    private var importePorAprobar: Double { pendientes.reduce(0) { $0 + $1.total } }

    private var porProveedor: [(nombre: String, total: Double)] {
        proveedores
            .map { ($0.nombre, $0.totalComprado) }
            .filter { $0.1 > 0 }
            .sorted { $0.1 > $1.1 }
    }

    private let columnas = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hola, \(sesion.usuario?.nombre ?? "") · \(sesion.usuario?.rol ?? "")")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    LazyVGrid(columns: columnas, spacing: 12) {
                        Indicador(titulo: "Valor del inventario", valor: valorInventario.soles,
                                  icono: "shippingbox.fill", color: .blue)                              // ②
                        Indicador(titulo: "Crédito fiscal (IGV)", valor: creditoFiscal.soles,
                                  icono: "percent", color: .purple)                                     // ③
                        Indicador(titulo: "Por pagar", valor: porPagar.soles,
                                  detalle: vencidas > 0 ? "\(vencidas) vencida(s)" : nil,
                                  icono: "creditcard.fill", color: .orange)
                        Indicador(titulo: "Por aprobar", valor: importePorAprobar.soles,
                                  detalle: "\(pendientes.count) compra(s)",
                                  icono: "checkmark.seal.fill", color: .teal)                           // ④
                    }

                    // ⑤ Total comprado por proveedor
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Total comprado por proveedor").font(.headline)
                        if porProveedor.isEmpty {
                            Text("Aún no hay compras aprobadas").foregroundStyle(.secondary)
                        } else {
                            Chart(porProveedor, id: \.nombre) { item in
                                BarMark(x: .value("Total", item.total),
                                        y: .value("Proveedor", item.nombre))
                                    .foregroundStyle(Color.teal.gradient)
                                    .annotation(position: .trailing) {
                                        Text(item.total.soles).font(.caption2)
                                    }
                            }
                            .chartXAxis(.hidden)
                            .frame(height: CGFloat(porProveedor.count) * 50 + 20)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Resumen")
            .conAvatar()                                                                                 // ①
        }
    }
}

struct Indicador: View {
    let titulo: String
    let valor: String
    var detalle: String? = nil
    let icono: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: icono).foregroundStyle(color)
            Text(titulo).font(.caption).foregroundStyle(.secondary)
            Text(valor).font(.headline.monospacedDigit()).minimumScaleFactor(0.7).lineLimit(1)
            if let detalle {
                Text(detalle).font(.caption2).foregroundStyle(color)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }
}
