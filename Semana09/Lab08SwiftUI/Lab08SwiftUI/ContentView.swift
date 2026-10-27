
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // MARK: - HStack
                SeccionDemo(
                    titulo: "HStack",
                    descripcion: "Organiza sus elementos en una fila horizontal, uno al lado del otro."
                ) {
                    HStack(spacing: 16) {
                        ForEach(["circle.fill", "square.fill", "triangle.fill"], id: \.self) { icono in
                            Image(systemName: icono)
                                .font(.system(size: 32))
                                .foregroundStyle(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.indigo.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }

                // MARK: - VStack
                SeccionDemo(
                    titulo: "VStack",
                    descripcion: "Organiza sus elementos en una columna vertical, uno debajo del otro."
                ) {
                    VStack(spacing: 8) {
                        ForEach(["Paso 1", "Paso 2", "Paso 3"], id: \.self) { paso in
                            Text(paso)
                                .font(.subheadline.bold())
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.teal.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }

                // MARK: - ZStack
                SeccionDemo(
                    titulo: "ZStack",
                    descripcion: "Superpone sus elementos, uno encima del otro, formando capas."
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 120)
                        VStack {
                            Text("Tarjeta sobre fondo")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text("Texto superpuesto con ZStack")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.85))
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Actividad 01 · Stacks")
    }
}

// MARK: - SeccionDemo

private struct SeccionDemo<Contenido: View>: View {
    let titulo: String
    let descripcion: String
    @ViewBuilder let contenido: Contenido

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(titulo)
                .font(.title2.bold())
            Text(descripcion)
                .font(.footnote)
                .foregroundStyle(.secondary)
            contenido
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
