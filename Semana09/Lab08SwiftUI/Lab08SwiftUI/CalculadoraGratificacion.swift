import Foundation

struct CalculadoraGratificacion {

    struct Resultado {
        let remuneracionComputable: Double
        let mesesTrabajados: Int
        let gratificacion: Double
    }

    enum Salida {
        case exito(Resultado)
        case error(String)
    }

    static func calcular(
        remuneracionComputable: Double,
        mesesTrabajados: Int
    ) -> Salida {

        guard remuneracionComputable > 0 else {
            return .error("La remuneración debe ser mayor que 0.")
        }

        guard (1...6).contains(mesesTrabajados) else {
            return .error("Los meses trabajados deben estar entre 1 y 6.")
        }

        let gratificacion =
            (remuneracionComputable / 6) * Double(mesesTrabajados)

        return .exito(
            Resultado(
                remuneracionComputable: remuneracionComputable,
                mesesTrabajados: mesesTrabajados,
                gratificacion: gratificacion
            )
        )
    }
}
