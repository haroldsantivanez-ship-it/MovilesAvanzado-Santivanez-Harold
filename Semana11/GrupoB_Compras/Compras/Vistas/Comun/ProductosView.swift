import SwiftUI
import SwiftData

/// B3 · ① + (solo supervisor) · ② Búsqueda · ③ Costo promedio y stock en color ·
/// ④ Valor del inventario · ⑤ Deslizar para borrar (solo supervisor, bloqueado si tiene compras)
struct ProductosView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var busqueda = ""
    @State private var productoEditar: Producto?
    @State private var mostrarNuevo = false
    @State private var mensajeBloqueo: String?

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    private var filtrados: [Producto] {
        guard !busqueda.isEmpty else { return productos }
        return productos.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda) ||
            $0.categoria.localizedCaseInsensitiveContains(busqueda)
        }
    }

    private var valorInventario: Double {
        productos.reduce(0) { $0 + $1.valorInventario }
    }

    var body: some View {
        NavigationStack {
            List {
                // ④ Valor total del inventario
                Section {
                    FilaMonto(titulo: "Valor del inventario", valor: valorInventario.soles, destacado: true)
                } footer: {
                    Text("Suma de stock × costo promedio")
                }

                Section("Productos") {
                    ForEach(filtrados) { producto in
                        FilaProducto(producto: producto)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if esSupervisor { productoEditar = producto }
                            }
                    }
                    // ⑤ onDelete solo existe para el supervisor
                    .onDelete(perform: esSupervisor ? borrar : nil)
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar producto o categoría")   // ②
            .navigationTitle("Productos")
            .toolbar {
                if esSupervisor {                                                // ①
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Nuevo", systemImage: "plus") { mostrarNuevo = true }
                    }
                }
            }
            .conAvatar()
            .overlay {
                if productos.isEmpty {
                    ContentUnavailableView("Sin productos", systemImage: "shippingbox",
                                           description: Text(esSupervisor ? "Pulsa + para agregar" : "Aún no hay productos"))
                }
            }
            .sheet(isPresented: $mostrarNuevo) { ProductoFormView(producto: nil) }
            .sheet(item: $productoEditar) { ProductoFormView(producto: $0) }
            .alert("No se puede borrar", isPresented: Binding(get: { mensajeBloqueo != nil }, set: { if !$0 { mensajeBloqueo = nil } })) {
                Button("Entendido") { mensajeBloqueo = nil }
            } message: {
                Text(mensajeBloqueo ?? "")
            }
        }
    }

    /// Regla .deny: si el producto tiene compras, no se borra y se avisa.
    private func borrar(_ offsets: IndexSet) {
        for index in offsets {
            let producto = filtrados[index]          // índices de la lista visible
            if !producto.compras.isEmpty {
                mensajeBloqueo = "\(producto.nombre) tiene \(producto.compras.count) compra(s) registrada(s)."
                return
            }
            modelContext.delete(producto)
        }
        try? modelContext.save()
    }
}

/// ③ Fila: nombre, categoría, costo promedio y stock en color
struct FilaProducto: View {
    let producto: Producto

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(producto.nombre).font(.headline)
                Text("\(producto.categoria) · Costo prom. \(producto.costoPromedio.soles)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Inventario: \(producto.valorInventario.soles)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("\(producto.stock)")
                .font(.headline.monospacedDigit())
                .foregroundStyle(colorStock(producto.stock))
                .frame(minWidth: 44)
                .padding(.vertical, 6)
                .background(colorStock(producto.stock).opacity(0.15), in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

/// Crear o editar producto (solo supervisor)
struct ProductoFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let producto: Producto?

    @State private var nombre = ""
    @State private var categoria = ""
    @State private var stock = 0
    @State private var costoPromedio = 0.0

    var body: some View {
        NavigationStack {
            Form {
                TextField("Nombre", text: $nombre)
                TextField("Categoría", text: $categoria)
                Stepper("Stock: \(stock)", value: $stock, in: 0...100_000)
                HStack {
                    Text("Costo promedio S/")
                    TextField("0.00", value: $costoPromedio, format: .number.precision(.fractionLength(2)))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle(producto == nil ? "Nuevo producto" : "Editar producto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { guardar() }
                        .disabled(nombre.isEmpty || categoria.isEmpty || costoPromedio < 0)
                }
            }
            .onAppear {
                if let producto {
                    nombre = producto.nombre
                    categoria = producto.categoria
                    stock = producto.stock
                    costoPromedio = producto.costoPromedio
                }
            }
        }
    }

    private func guardar() {
        if let producto {
            producto.nombre = nombre
            producto.categoria = categoria
            producto.stock = stock
            producto.costoPromedio = costoPromedio
        } else {
            modelContext.insert(Producto(nombre: nombre, categoria: categoria,
                                         stock: stock, costoPromedio: costoPromedio))
        }
        try? modelContext.save()
        dismiss()
    }
}
