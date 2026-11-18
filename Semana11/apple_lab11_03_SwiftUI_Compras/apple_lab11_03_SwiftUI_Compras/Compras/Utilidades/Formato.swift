import SwiftUI

extension Double {
    /// 1416.0 → "S/ 1,416.00"
    var soles: String {
        "S/ " + self.formatted(.number.precision(.fractionLength(2)).locale(Locale(identifier: "en_US")))
    }

    /// 115.5555 → "115.56"
    var dosDecimales: String {
        self.formatted(.number.precision(.fractionLength(2)).locale(Locale(identifier: "en_US")))
    }
}

extension Date {
    var corta: String { self.formatted(date: .abbreviated, time: .omitted) }
}

/// Color del stock: verde más de 10, ámbar de 6 a 10, rojo 5 o menos
func colorStock(_ stock: Int) -> Color {
    switch stock {
    case ...5:  return .red
    case 6...10: return .orange
    default:     return .green
    }
}

/// Etiqueta pequeña tipo "insignia"
struct Insignia: View {
    let texto: String
    let color: Color

    var body: some View {
        Text(texto)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.15), in: Capsule())
            .foregroundStyle(color)
    }
}

/// Fila "etiqueta ........ valor" usada en resúmenes
struct FilaMonto: View {
    let titulo: String
    let valor: String
    var destacado = false

    var body: some View {
        HStack {
            Text(titulo)
            Spacer()
            Text(valor).monospacedDigit()
        }
        .font(destacado ? .headline : .body)
    }
}

/// 🎨 Colores de la app. Cambia SOLO estas dos líneas para darle otro estilo.
enum Tema {
    static let principal = Color(red: 0.43, green: 0.27, blue: 0.84)   // morado (botones, pestañas, logo, comprador)
    static let secundario = Color(red: 0.85, green: 0.22, blue: 0.55)  // fucsia (avatar del supervisor)
}
