//
//  DisenoApp.swift
//  Diseño propio de la app: paleta, avatares y componentes reutilizables
//  Harold Santivañez — Lab 13
//

import SwiftUI

// MARK: - Paleta de colores

enum Paleta {
    static let indigo   = Color(red: 0.36, green: 0.27, blue: 0.95)
    static let turquesa = Color(red: 0.05, green: 0.73, blue: 0.75)
    static let fondo    = Color(red: 0.96, green: 0.96, blue: 0.99)

    /// Degradado principal de la cabecera y los botones
    static let degradado = LinearGradient(colors: [indigo, turquesa],
                                          startPoint: .topLeading, endPoint: .bottomTrailing)

    /// Cada usuario recibe un degradado según su id
    private static let tonos: [[Color]] = [
        [Color(red: 0.98, green: 0.42, blue: 0.36), Color(red: 0.99, green: 0.71, blue: 0.30)],
        [Color(red: 0.40, green: 0.33, blue: 0.96), Color(red: 0.69, green: 0.45, blue: 0.99)],
        [Color(red: 0.07, green: 0.70, blue: 0.62), Color(red: 0.36, green: 0.86, blue: 0.55)],
        [Color(red: 0.93, green: 0.29, blue: 0.60), Color(red: 0.99, green: 0.55, blue: 0.62)],
        [Color(red: 0.13, green: 0.55, blue: 0.95), Color(red: 0.31, green: 0.83, blue: 0.98)],
        [Color(red: 0.95, green: 0.60, blue: 0.10), Color(red: 0.98, green: 0.82, blue: 0.25)]
    ]

    static func avatar(_ id: Int) -> LinearGradient {
        let c = tonos[abs(id) % tonos.count]
        return LinearGradient(colors: c, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

/// "Mrs. Dennis Schulist" → "DS" (ignora títulos como Mrs. o Mr.)
func iniciales(_ nombre: String) -> String {
    let partes = nombre.split(separator: " ").filter { !$0.hasSuffix(".") }
    let letras = partes.prefix(2).compactMap { $0.first }.map(String.init).joined()
    return letras.isEmpty ? "?" : letras.uppercased()
}

// MARK: - Avatar con iniciales

struct AvatarUsuario: View {
    let id: Int
    let nombre: String
    var tamano: CGFloat = 48

    var body: some View {
        Text(iniciales(nombre))
            .font(.system(size: tamano * 0.36, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .frame(width: tamano, height: tamano)
            .background(Paleta.avatar(id), in: RoundedRectangle(cornerRadius: tamano * 0.32, style: .continuous))
    }
}

// MARK: - Cabecera con degradado

struct CabeceraDegradada<Contenido: View>: View {
    let titulo: String
    let subtitulo: String
    @ViewBuilder var contenido: Contenido

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(subtitulo.uppercased())
                        .font(.caption.weight(.semibold))
                        .tracking(1.2)
                        .foregroundStyle(.white.opacity(0.75))
                    Text(titulo)
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                }
                Spacer()
                Image(systemName: "person.2.wave.2.fill")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 46, height: 46)
                    .background(.white.opacity(0.18), in: Circle())
            }
            contenido
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Paleta.degradado
                .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 32, bottomTrailingRadius: 32,
                                                  style: .continuous))
                .ignoresSafeArea(edges: .top)
        )
    }
}

// MARK: - Buscador tipo cápsula (vidrio)

struct BuscadorCapsula: View {
    @Binding var texto: String
    var placeholder: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white.opacity(0.85))
            TextField("", text: $texto, prompt: Text(placeholder).foregroundStyle(.white.opacity(0.7)))
                .foregroundStyle(.white)
                .tint(.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            if !texto.isEmpty {
                Button {
                    texto = ""
                } label: {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(.white.opacity(0.85))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(.white.opacity(0.18), in: Capsule())
        .overlay(Capsule().stroke(.white.opacity(0.35), lineWidth: 1))
    }
}

// MARK: - Chip de estadística

struct ChipDato: View {
    let icono: String
    let texto: String

    var body: some View {
        Label(texto, systemImage: icono)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(.white.opacity(0.16), in: Capsule())
    }
}

// MARK: - Fila de usuario (tarjeta)

struct FilaUsuario: View {
    let id: Int
    let nombre: String
    var email: String? = nil

    var body: some View {
        HStack(spacing: 14) {
            AvatarUsuario(id: id, nombre: nombre)
            VStack(alignment: .leading, spacing: 3) {
                Text(nombre)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.primary)
                if let email {
                    Label(email, systemImage: "envelope.fill")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .labelStyle(.titleAndIcon)
                        .lineLimit(1)
                }
            }
            Spacer(minLength: 8)
            Text("#\(id)")
                .font(.caption.weight(.bold).monospacedDigit())
                .foregroundStyle(Paleta.indigo)
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(Paleta.indigo.opacity(0.10), in: Capsule())
        }
        .padding(14)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Paleta.indigo.opacity(0.08), radius: 12, y: 6)
    }
}

extension View {
    /// Quita el estilo por defecto de la fila de una List para que se vea como tarjeta
    func filaTarjeta() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
    }
}
