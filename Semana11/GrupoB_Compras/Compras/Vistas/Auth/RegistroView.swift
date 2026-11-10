import SwiftUI
import SwiftData

/// B2 · ① Título y volver · ② Nombre · ③ Usuario único (aviso si existe) ·
/// ④ Clave (mín. 6) y confirmación · ⑤ Rol · ⑥ Registrarme (entra directo)
struct RegistroView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var confirmacion = ""
    @State private var rol = Rol.comprador
    @State private var mensajeError: String?

    // ③ Aviso en vivo mientras escribe
    private var usuarioRepetido: Bool {
        !usuario.isEmpty && Autenticacion.existeUsuario(usuario, en: modelContext)
    }

    var body: some View {
        Form {
            Section("Datos personales") {
                TextField("Nombre completo", text: $nombre)          // ②
            }

            Section {
                TextField("Usuario", text: $usuario)                 // ③
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } header: {
                Text("Usuario")
            } footer: {
                if usuarioRepetido {
                    Text("Ese usuario ya existe").foregroundStyle(.red)
                }
            }

            Section {
                SecureField("Clave (mínimo 6)", text: $clave)        // ④
                SecureField("Confirmar clave", text: $confirmacion)
            } header: {
                Text("Clave")
            } footer: {
                if !clave.isEmpty && clave.count < 6 {
                    Text("Mínimo 6 caracteres").foregroundStyle(.red)
                } else if !confirmacion.isEmpty && clave != confirmacion {
                    Text("Las claves no coinciden").foregroundStyle(.red)
                }
            }

            Section("Rol") {                                          // ⑤
                Picker("Rol", selection: $rol) {
                    Text(Rol.comprador).tag(Rol.comprador)
                    Text(Rol.supervisor).tag(Rol.supervisor)
                }
                .pickerStyle(.segmented)
            }

            if let mensajeError {
                Section {
                    Label(mensajeError, systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                }
            }

            Section {
                Button("Registrarme") { registrar() }                 // ⑥
                    .frame(maxWidth: .infinity)
                    .bold()
            }
        }
        .navigationTitle("Crear cuenta")                              // ① (el botón volver lo pone NavigationStack)
    }

    private func registrar() {
        do {
            let nuevo = try Autenticacion.registrar(
                nombre: nombre, usuario: usuario, clave: clave,
                confirmacion: confirmacion, rol: rol, en: modelContext)
            sesion.usuario = nuevo     // entra directo a la app
        } catch {
            mensajeError = error.localizedDescription
        }
    }
}
