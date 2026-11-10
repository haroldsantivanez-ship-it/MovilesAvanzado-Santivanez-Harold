import SwiftUI
import SwiftData

/// B5 · ① Avatar · ② Proveedor · ③ Producto · ④ Cantidad · ⑤ Contado o Crédito 30 días ·
/// ⑥ Aviso cuando el total llega a S/ 5,000 · ⑦ "Enviar a aprobación" o "Registrar compra"
struct NuevaCompraView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var proveedor: Proveedor?
    @State private var producto: Producto?
    @State private var cantidad = 1
    @State private var costoTexto = ""          // texto del campo; se convierte a número al vuelo
    @State private var alCredito = false
    @State private var resultado: String?

    /// "120" o "120,50" → 120.0 / 120.5 (se actualiza mientras escribes)
    private var costoUnitario: Double {
        Double(costoTexto.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private var montos: ReglasCompra.Montos {
        ReglasCompra.calcular(cantidad: cantidad, costoUnitario: costoUnitario)
    }
    private var requiereAprobacion: Bool { ReglasCompra.requiereAprobacion(total: montos.total) }
    private var formularioValido: Bool { proveedor != nil && producto != nil && cantidad > 0 && costoUnitario > 0 }

    var body: some View {
        NavigationStack {
            Form {
                Section("Comprador") {
                    LabeledContent("Registrado por", value: sesion.usuario?.nombre ?? "-")   // automático
                }

                Section("Compra") {
                    Picker("Proveedor", selection: $proveedor) {                          // ②
                        Text("Selecciona").tag(Proveedor?.none)
                        ForEach(proveedores) { Text($0.nombre).tag(Optional($0)) }
                    }
                    Picker("Producto", selection: $producto) {                            // ③
                        Text("Selecciona").tag(Producto?.none)
                        ForEach(productos) { Text($0.nombre).tag(Optional($0)) }
                    }
                    if let producto {
                        LabeledContent("Stock actual", value: "\(producto.stock)")
                        LabeledContent("Costo promedio", value: producto.costoPromedio.soles)
                    }
                    Stepper("Cantidad: \(cantidad)", value: $cantidad, in: 1...10_000)    // ④
                    HStack {
                        Text("Costo unitario S/")
                        TextField("0.00", text: $costoTexto)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section("Forma de pago") {                                                // ⑤
                    Picker("Pago", selection: $alCredito) {
                        Text("Contado").tag(false)
                        Text("Crédito 30 días").tag(true)
                    }
                    .pickerStyle(.segmented)
                    if alCredito {
                        let vence = Calendar.current.date(byAdding: .day, value: ReglasCompra.diasCredito, to: .now)!
                        LabeledContent("Vence", value: vence.corta)
                    }
                }

                Section("Resumen") {
                    FilaMonto(titulo: "Subtotal", valor: montos.subtotal.soles)
                    FilaMonto(titulo: "IGV 18 % (crédito fiscal)", valor: montos.igv.soles)
                    FilaMonto(titulo: "Total", valor: montos.total.soles, destacado: true)
                }

                if requiereAprobacion {                                                   // ⑥
                    Section {
                        Label("El total llega a S/ 5,000: la compra quedará Pendiente hasta que el supervisor la apruebe.",
                              systemImage: "exclamationmark.shield.fill")
                            .foregroundStyle(.orange)
                            .font(.footnote)
                    }
                }

            }
            .scrollDismissesKeyboard(.interactively)        // al deslizar se esconde el teclado
            // ⑦ Barra fija abajo: total + botón siempre visibles (no hace falta bajar)
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    HStack {
                        Text("Total").font(.headline)
                        Spacer()
                        Text(montos.total.soles).font(.title3.bold()).monospacedDigit()
                    }
                    Button {
                        registrar()
                    } label: {
                        Text(requiereAprobacion ? "Enviar a aprobación" : "Registrar compra")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(requiereAprobacion ? Color.orange : Color.accentColor)
                    .disabled(!formularioValido)
                }
                .padding()
                .background(.bar)
            }
            .navigationTitle("Nueva compra")
            .conAvatar()                                                                   // ①
            .onChange(of: producto) { _, nuevo in
                // Sugerimos el costo promedio como costo unitario (se puede cambiar)
                if let nuevo, costoTexto.isEmpty { costoTexto = String(format: "%.2f", nuevo.costoPromedio) }
            }
            .alert("Compra registrada",
                   isPresented: Binding(get: { resultado != nil }, set: { if !$0 { resultado = nil } })) {
                Button("OK") { resultado = nil }
            } message: {
                Text(resultado ?? "")
            }
        }
    }

    private func registrar() {
        guard let usuario = sesion.usuario, let proveedor, let producto else { return }
        let compra = ReglasCompra.registrar(cantidad: cantidad, costoUnitario: costoUnitario,
                                            alCredito: alCredito, comprador: usuario,
                                            proveedor: proveedor, producto: producto, en: modelContext)
        if compra.estado == EstadoCompra.aprobada {
            resultado = "Total \(compra.total.soles) · Aprobada.\nStock \(producto.stock) · costo promedio \(producto.costoPromedio.soles)"
        } else {
            resultado = "Total \(compra.total.soles) · Pendiente de aprobación del supervisor."
        }
        // Limpiar el formulario
        self.producto = nil
        cantidad = 1
        costoTexto = ""
        alCredito = false
    }
}
