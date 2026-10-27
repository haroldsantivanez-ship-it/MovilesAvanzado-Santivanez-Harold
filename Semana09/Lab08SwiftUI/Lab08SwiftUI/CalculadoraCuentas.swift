
import Foundation

// MARK: - CalculadoraCuentas

struct CalculadoraCuentas {
    struct Entrada {
        var cxcInicial: Double
        var cxcFinal: Double
        var ventasCredito: Double
        var cxcVencidas: Double
        var porcentajeIncobrabilidad: Double
        var cxpInicial: Double
        var cxpFinal: Double
        var comprasCredito: Double
        var pasivosTotales: Double
    }

    struct Resultado {
        let edadPromedioCxC: Double
        let rotacionCxC: Double
        let indiceMorosidad: Double
        let provisionIncobrables: Double
        let edadPromedioCxP: Double
        let rotacionCxP: Double
        let indiceEndeudamiento: Double
        let cicloFinanciero: Double
    }

    enum Salida {
        case exito(Resultado)
        case error(String)
    }

    static func calcular(_ entrada: Entrada) -> Salida {
        let valores = [
            entrada.cxcInicial, entrada.cxcFinal, entrada.ventasCredito, entrada.cxcVencidas,
            entrada.porcentajeIncobrabilidad, entrada.cxpInicial, entrada.cxpFinal,
            entrada.comprasCredito, entrada.pasivosTotales
        ]
        guard valores.allSatisfy({ $0 >= 0 }) else {
            return .error("Todos los valores deben ser números no negativos.")
        }

        let cxcPromedio = (entrada.cxcInicial + entrada.cxcFinal) / 2
        let cxcTotales = entrada.cxcFinal
        let cxpPromedio = (entrada.cxpInicial + entrada.cxpFinal) / 2
        let cxpTotales = entrada.cxpFinal

        guard entrada.ventasCredito > 0, entrada.comprasCredito > 0, cxcTotales > 0,
              entrada.pasivosTotales > 0, cxcPromedio > 0, cxpPromedio > 0 else {
            return .error("Las ventas a crédito, compras a crédito, saldos finales, promedios y pasivos totales deben ser mayores que 0 para evitar divisiones entre 0.")
        }

        let edadPromedioCxC = cxcPromedio * 360 / entrada.ventasCredito
        let rotacionCxC = entrada.ventasCredito / cxcPromedio
        let indiceMorosidad = entrada.cxcVencidas / cxcTotales * 100
        let provisionIncobrables = cxcTotales * entrada.porcentajeIncobrabilidad / 100

        let edadPromedioCxP = cxpPromedio * 360 / entrada.comprasCredito
        let rotacionCxP = entrada.comprasCredito / cxpPromedio
        let indiceEndeudamiento = cxpTotales / entrada.pasivosTotales * 100

        let cicloFinanciero = edadPromedioCxC - edadPromedioCxP

        return .exito(
            Resultado(
                edadPromedioCxC: edadPromedioCxC,
                rotacionCxC: rotacionCxC,
                indiceMorosidad: indiceMorosidad,
                provisionIncobrables: provisionIncobrables,
                edadPromedioCxP: edadPromedioCxP,
                rotacionCxP: rotacionCxP,
                indiceEndeudamiento: indiceEndeudamiento,
                cicloFinanciero: cicloFinanciero
            )
        )
    }
}
