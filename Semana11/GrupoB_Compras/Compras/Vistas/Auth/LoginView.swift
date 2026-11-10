import SwiftUI
import SwiftData

/// B1 · ① Logo y nombre · ② Usuario · ③ Clave oculta · ④ Error genérico · ⑤ Ingresar · ⑥ Crear cuenta
struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @State private var usuario = ""
    @State private var clave = ""
    @State private var mensajeError: String?
    @State private var mostrarRegistro = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // ① Logo y nombre
                VStack(spacing: 8) {
                    Image(systemName: "cart.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.white)
                        .frame(width: 88, height: 88)
                        .background(Color.teal.gradient, in: RoundedRectangle(cornerRadius: 22))
                    Text("Compras").font(.largeTitle.bold())
                    Text("Distribuidora · Tecsup").foregroundStyle(.secondary)
                }
                .padding(.top, 40)

                VStack(spacing: 12) {
                    // ② Usuario
                    TextField("Usuario", text: $usuario)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
                    // ③ Clave oculta
                    SecureField("Clave", text: $clave)
                        .padding()
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
                }

                // ④ Mensaje genérico (no dice si falló el usuario o la clave)
                if let mensajeError {
                    Label(mensajeError, systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                        .font(.footnote)
                }

                // ⑤ Ingresar
                Button {
                    ingresar()
                } label: {
                    Text("Ingresar").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(usuario.isEmpty || clave.isEmpty)

                // ⑥ Ir a Crear cuenta
                Button("¿No tienes cuenta? Crear cuenta") { mostrarRegistro = true }

                Spacer()

                Button("Cargar datos de prueba") {
                    DatosDemo.cargar(en: modelContext)
                    mensajeError = nil
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 24)
            .navigationDestination(isPresented: $mostrarRegistro) {
                RegistroView()
            }
        }
    }

    private func ingresar() {
        if let encontrado = Autenticacion.login(usuario: usuario, clave: clave, en: modelContext) {
            mensajeError = nil
            sesion.usuario = encontrado        // RootView cambia sola al TabView del rol
        } else {
            mensajeError = "Usuario o clave incorrectos"
            clave = ""
        }
    }
}

#Preview {
    LoginView()
        .environment(Sesion())
        .modelContainer(for: [Usuario.self, Proveedor.self, Producto.self, Compra.self], inMemory: true)
}
