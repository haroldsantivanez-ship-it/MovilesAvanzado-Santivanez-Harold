//
//  TemaNeon.swift
//  Lab14IntroFirebase — Diseño moderno y sobrio: fondo oscuro, acento cian-violeta y componentes de vidrio
//  Harold Santivañez
//

import SwiftUI

// MARK: - Paleta (acento sobrio)

enum Neon {
    static let fondo   = Color(red: 0.05, green: 0.06, blue: 0.10)
    static let cian    = Color(red: 0.30, green: 0.78, blue: 0.95)
    static let violeta = Color(red: 0.45, green: 0.42, blue: 0.95)
    static let magenta = Color(red: 0.95, green: 0.42, blue: 0.50)   // solo para cerrar sesión y errores
    static let verde   = Color(red: 0.35, green: 0.85, blue: 0.60)

    static let degradado = LinearGradient(colors: [cian, violeta],
                                          startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - Fondo oscuro con luces suaves y cuadrícula tenue

struct FondoFuturista: View {
    @State private var mover = false

    var body: some View {
        ZStack {
            Neon.fondo

            // Orbes de luz que se mueven lentamente
            Circle().fill(Neon.violeta).frame(width: 340).blur(radius: 140).opacity(0.30)
                .offset(x: mover ? -120 : 90, y: mover ? -300 : -220)
            Circle().fill(Neon.cian).frame(width: 300).blur(radius: 150).opacity(0.22)
                .offset(x: mover ? 140 : -60, y: mover ? 280 : 340)

            // Cuadrícula tenue tipo holograma
            Canvas { ctx, size in
                let paso: CGFloat = 34
                var lineas = Path()
                stride(from: 0, through: size.width, by: paso).forEach {
                    lineas.move(to: CGPoint(x: $0, y: 0)); lineas.addLine(to: CGPoint(x: $0, y: size.height))
                }
                stride(from: 0, through: size.height, by: paso).forEach {
                    lineas.move(to: CGPoint(x: 0, y: $0)); lineas.addLine(to: CGPoint(x: size.width, y: $0))
                }
                ctx.stroke(lineas, with: .color(.white.opacity(0.02)), lineWidth: 1)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 12).repeatForever(autoreverses: true)) { mover = true }
        }
    }
}

// MARK: - Tarjeta de vidrio

struct TarjetaVidrio: ViewModifier {
    var radio: CGFloat = 28
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial.opacity(0.55), in: RoundedRectangle(cornerRadius: radio, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radio, style: .continuous)
                    .stroke(LinearGradient(colors: [.white.opacity(0.18), .white.opacity(0.04)],
                                           startPoint: .top, endPoint: .bottom), lineWidth: 1)
            )
    }
}

extension View {
    func vidrio(radio: CGFloat = 28) -> some View { modifier(TarjetaVidrio(radio: radio)) }

    /// Sombra suave de color (discreta)
    func brillo(_ color: Color, radio: CGFloat = 14) -> some View {
        shadow(color: color.opacity(0.25), radius: radio * 0.6)
    }
}

// MARK: - Campo de texto

struct CampoNeon<Campo: View>: View {
    let icono: String
    let activo: Bool
    @ViewBuilder var campo: Campo

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icono)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(activo ? AnyShapeStyle(Neon.cian) : AnyShapeStyle(Color.white.opacity(0.45)))
                .frame(width: 22)
            campo
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.white)
                .tint(Neon.cian)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(.white.opacity(activo ? 0.10 : 0.06), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(activo ? AnyShapeStyle(Neon.cian.opacity(0.8)) : AnyShapeStyle(Color.white.opacity(0.10)),
                        lineWidth: 1)
        )
        .animation(.easeOut(duration: 0.2), value: activo)
    }
}

// MARK: - Aviso tipo HUD (reemplaza al alert del sistema)

struct AvisoHUD: View {
    let mensaje: String
    let esError: Bool
    let cerrar: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.55).ignoresSafeArea().onTapGesture(perform: cerrar)

            VStack(spacing: 16) {
                Image(systemName: esError ? "exclamationmark.triangle.fill" : "checkmark.seal.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(esError ? Neon.magenta : Neon.verde)
                Text(esError ? "ATENCIÓN" : "SISTEMA")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .tracking(3)
                    .foregroundStyle(.white.opacity(0.6))
                Text(mensaje)
                    .font(.system(.body, design: .rounded).weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Button(action: cerrar) {
                    Text("OK")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(24)
            .frame(maxWidth: 300)
            .vidrio()
            .transition(.scale(scale: 0.85).combined(with: .opacity))
        }
    }
}

// MARK: - Button Styles (rediseñados)

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded))
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Neon.degradado, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(duration: 0.25), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded))
            .foregroundStyle(Neon.cian)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.05), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Neon.cian.opacity(0.5), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(duration: 0.25), value: configuration.isPressed)
    }
}

struct SignOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded))
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 28)
            .background(Neon.magenta.opacity(0.15), in: Capsule())
            .overlay(Capsule().stroke(Neon.magenta.opacity(0.6), lineWidth: 1))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

/// "jgomezm@tecsup.edu.pe" → "J"
func inicial(_ email: String) -> String {
    String(email.first ?? "?").uppercased()
}
