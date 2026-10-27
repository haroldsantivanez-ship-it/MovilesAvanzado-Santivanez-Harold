
import Foundation

// MARK: - CalculadoraCTS

struct CalculadoraCTS {
    struct Resultado {
        let sextoGratificacion: Double
        let remuneracionComputable: Double
        let cts: Double
    }

    enum Salida {
        case exito(Resultado)
        case error(String)
    }

    static func calcular(sueldo: Double, gratificacion: Double, mesesTrabajados: Int) -> Salida {
        guard sueldo >= 0, gratificacion >= 0 else {
            return .error("El sueldo y la gratificación deben ser valores no negativos.")
        }
        guard (1...6).contains(mesesTrabajados) else {
            return .error("Los meses trabajados deben estar entre 1 y 6.")
        }

        let sextoGratificacion = gratificacion / 6
        let remuneracionComputable = sueldo + sextoGratificacion
        let cts = remuneracionComputable * (Double(mesesTrabajados) / 12)

        return .exito(
            Resultado(
                sextoGratificacion: sextoGratificacion,
                remuneracionComputable: remuneracionComputable,
                cts: cts
            )
        )
    }
}
