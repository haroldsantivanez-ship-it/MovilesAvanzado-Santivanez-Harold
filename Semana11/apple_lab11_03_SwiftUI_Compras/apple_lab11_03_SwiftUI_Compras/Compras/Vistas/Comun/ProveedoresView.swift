import SwiftUI
import SwiftData

/// B4 · ① + (solo supervisor) · ② Insignia "por pagar" o "Al día" y total comprado ·
/// ③ Valores calculados desde las compras del proveedor (relación proveedor.compras)
struct ProveedoresView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]

    @State private var busqueda = ""
    @State private var proveedorEditar: Proveedor?
    @State private var mostrarNuevo = false
    @State private var mostrarBloqueo = false
    @State private var mensajeBloqueo = ""

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    private var filtrados: [Proveedor] {
        if busqueda.isEmpty { return proveedores }
        return proveedores.filter { p in
            p.nombre.localizedCaseInsensitiveContains(busqueda) || p.ruc.contains(busqueda)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filtrados) { proveedor in
                    FilaProveedor(proveedor: proveedor)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if esSupervisor { proveedorEditar = proveedor }
                        }
                }
                .onDelete(perform: borrar)
                .deleteDisabled(!esSupervisor)          // el comprador no puede deslizar para borrar
            }
            .searchable(text: $busqueda, prompt: "Buscar por nombre o RUC")
            .navigationTitle("Proveedores")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if esSupervisor {                    // ① botón + solo para el supervisor
                        Button {
                            mostrarNuevo = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .conAvatar()
            .sheet(isPresented: $mostrarNuevo) {
                ProveedorFormView(proveedor: nil)
            }
            .sheet(item: $proveedorEditar) { proveedor in
                ProveedorFormView(proveedor: proveedor)
            }
            .alert("No se puede borrar", isPresented: $mostrarBloqueo) {
                Button("Entendido", role: .cancel) { }
            } message: {
                Text(mensajeBloqueo)
            }
        }
    }

    /// Regla .deny: si el proveedor tiene compras, no se borra y se avisa.
    private func borrar(_ offsets: IndexSet) {
        guard esSupervisor else { return }
        for index in offsets {
            let proveedor = filtrados[index]
            if !proveedor.compras.isEmpty {
                mensajeBloqueo = "\(proveedor.nombre) tiene compras registradas."
                mostrarBloqueo = true
                return
            }
            modelContext.delete(proveedor)
        }
        try? modelContext.save()
    }
}

struct FilaProveedor: View {
    let proveedor: Proveedor

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(proveedor.nombre).font(.headline)
                Text("RUC \(proveedor.ruc)").font(.caption).foregroundStyle(.secondary)
                Text("Comprado: \(proveedor.totalComprado.soles)").font(.subheadline)
            }
            Spacer()
            if proveedor.porPagar > 0 {
                VStack(alignment: .trailing, spacing: 4) {
                    Insignia(texto: "por pagar", color: .orange)
                    Text(proveedor.porPagar.soles).font(.caption)
                }
            } else {
                Insignia(texto: "Al día", color: .green)
            }
        }
    }
}

struct ProveedorFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let proveedor: Proveedor?

    @State private var nombre = ""
    @State private var ruc = ""

    private var rucValido: Bool {
        ruc.count == 11 && ruc.allSatisfy { $0.isNumber }
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Razón social", text: $nombre)
                Section {
                    TextField("RUC (11 dígitos)", text: $ruc)
                        .keyboardType(.numberPad)
                } footer: {
                    if !ruc.isEmpty && !rucValido {
                        Text("El RUC debe tener 11 dígitos").foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle(proveedor == nil ? "Nuevo proveedor" : "Editar proveedor")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { guardar() }
                        .disabled(nombre.isEmpty || !rucValido)
                }
            }
            .onAppear {
                if let proveedor {
                    nombre = proveedor.nombre
                    ruc = proveedor.ruc
                }
            }
        }
    }

    private func guardar() {
        if let proveedor {
            proveedor.nombre = nombre
            proveedor.ruc = ruc
        } else {
            modelContext.insert(Proveedor(nombre: nombre, ruc: ruc))
        }
        try? modelContext.save()
        dismiss()
    }
}
