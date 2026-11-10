import SwiftUI

/// Avatar de la sesión con menú: nombre, usuario, rol y Cerrar sesión.
/// Cumple la "Cuenta" del Grupo B (menú del avatar en vez de una pestaña).
struct AvatarMenu: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        if let usuario = sesion.usuario {
            Menu {
                Section {
                    Text(usuario.nombre)
                    Text("@\(usuario.usuario)")
                    Text("Rol: \(usuario.rol)")
                }
                Button("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) {
                    sesion.cerrar()          // usuario = nil → RootView vuelve al login sola
                }
            } label: {
                Text(usuario.iniciales)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(usuario.esSupervisor ? Color.indigo : Color.teal, in: Circle())
            }
            .accessibilityLabel("Cuenta de \(usuario.nombre)")
        }
    }
}

extension View {
    /// Agrega el avatar en la esquina superior derecha de la pantalla
    func conAvatar() -> some View {
        toolbar {
            ToolbarItem(placement: .topBarTrailing) { AvatarMenu() }
        }
    }
}
