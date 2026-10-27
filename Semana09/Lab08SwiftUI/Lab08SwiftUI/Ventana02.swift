
import SwiftUI

struct Ventana02: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Tarjeta de perfil (ZStack + VStack + HStack anidados)
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(colors: [.indigo, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 220)

                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 72))
                            .foregroundStyle(.white)
                            .shadow(radius: 4)

                        VStack(spacing: 4) {
                            Text("Harold Santivañez Garcia")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            Text("Estudiante de Móviles Avanzado")
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.85))
                        }

                        HStack(spacing: 24) {
                            EstadisticaView(icono: "star.fill", valor: "4.8", etiqueta: "Rating")
                            EstadisticaView(icono: "doc.text.fill", valor: "12", etiqueta: "Labs")
                            EstadisticaView(icono: "flame.fill", valor: "7", etiqueta: "Racha")
                        }
                        .padding(.bottom, 16)
                    }
                    .padding(.top, 16)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Text("Esta tarjeta combina ZStack (fondo con degradado), VStack (avatar, nombre y descripción) y HStack (fila de estadísticas) en un solo diseño.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Ventana 02")
    }
}

// MARK: - EstadisticaView

private struct EstadisticaView: View {
    let icono: String
    let valor: String
    let etiqueta: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icono)
                .foregroundStyle(.white)
            Text(valor)
                .font(.headline)
                .foregroundStyle(.white)
            Text(etiqueta)
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.8))
        }
    }
}

#Preview {
    NavigationStack {
        Ventana02()
    }
}
