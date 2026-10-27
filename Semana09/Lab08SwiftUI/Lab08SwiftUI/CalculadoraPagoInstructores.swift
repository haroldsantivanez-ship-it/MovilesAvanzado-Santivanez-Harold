
import Foundation

// MARK: - CalculadoraPagoInstructores

struct CalculadoraPagoInstructores {
    enum SistemaPensiones: String, CaseIterable, Identifiable {
        case afp = "AFP (10%)"
        case onp = "ONP (13%)"

        var id: String { rawValue }

        var tasa: Double {
            switch self {
            case .afp: return 0.10
            case .onp: return 0.13
            }
        }
    }

    static let pagoPorHora: Double = 50
    static let uit2026: Double = 5500

    struct Resultado {
        let bruto: Double
        let aportePensionario: Double
        let rentaBrutaAnual: Double
        let rentaNetaAnual: Double
        let irMensual: Double
        let esSalud: Double
        let neto: Double
    }

    enum Salida {
        case exito(Resultado)
        case error(String)
    }

    static func calcular(horasSemanales: Int, sistema: SistemaPensiones) -> Salida {
        guard (1...23).contains(horasSemanales) else {
            return .error("Las horas semanales deben estar entre 1 y 23.")
        }

        let bruto = Double(horasSemanales) * pagoPorHora * 4
        let aportePensionario = bruto * sistema.tasa

        let rentaBrutaAnual = bruto * 14
        let rentaNetaAnual = max(0, rentaBrutaAnual - 7 * uit2026)
        let irAnual = impuestoAnual(rentaNeta: rentaNetaAnual)
        let irMensual = irAnual / 12

        let esSalud = bruto * 0.09
        let neto = bruto - aportePensionario - irMensual

        return .exito(
            Resultado(
                bruto: bruto,
                aportePensionario: aportePensionario,
                rentaBrutaAnual: rentaBrutaAnual,
                rentaNetaAnual: rentaNetaAnual,
                irMensual: irMensual,
                esSalud: esSalud,
                neto: neto
            )
        )
    }

    /// Tramos progresivos de Impuesto a la Renta de 5ta categoría sobre la renta neta anual.
    private static func impuestoAnual(rentaNeta: Double) -> Double {
        let limites = [5.0, 20.0, 35.0, 45.0].map { $0 * uit2026 }
        let tasas = [0.08, 0.14, 0.17, 0.20, 0.30]

        var restante = rentaNeta
        var impuesto = 0.0
        var limiteAnterior = 0.0

        for (indice, limite) in limites.enumerated() {
            if restante <= 0 { break }
            let anchoTramo = limite - limiteAnterior
            let baseEnTramo = min(restante, anchoTramo)
            impuesto += baseEnTramo * tasas[indice]
            restante -= baseEnTramo
            limiteAnterior = limite
        }

        if restante > 0 {
            impuesto += restante * tasas[4]
        }

        return impuesto
    }
}
