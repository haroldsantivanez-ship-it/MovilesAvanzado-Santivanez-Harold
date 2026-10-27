
import Foundation

// MARK: - CalculadoraNotas

struct CalculadoraNotas {
    struct Resultado {
        let notaEliminada: String
        let promedioSinRedondear: Double
        let promedioFinal: Int
        let aprobado: Bool
    }

    enum Salida {
        case exito(Resultado)
        case error(String)
    }

    static func calcular(notas: [String]) -> Salida {
        var valores: [Double] = []
        var esAN: [Bool] = []
        var textos: [String] = []

        for texto in notas {
            let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
            textos.append(limpio)

            if limpio.uppercased() == "AN" {
                valores.append(0)
                esAN.append(true)
            } else if let numero = Double(limpio.replacingOccurrences(of: ",", with: ".")), numero >= 0, numero <= 20 {
                valores.append(numero)
                esAN.append(false)
            } else {
                return .error("Cada nota debe ser un número entre 0 y 20, o \"AN\".")
            }
        }

        var indiceEliminar: Int?
        for i in 0..<valores.count where !esAN[i] {
            if let actual = indiceEliminar {
                if valores[i] < valores[actual] { indiceEliminar = i }
            } else {
                indiceEliminar = i
            }
        }

        var restantes = valores
        var notaEliminada = "Ninguna (todas AN)"
        if let idx = indiceEliminar {
            notaEliminada = textos[idx]
            restantes.remove(at: idx)
        }

        let suma = restantes.reduce(0, +)
        let promedioSinRedondear = suma / Double(restantes.count)
        let promedioFinal = Int(promedioSinRedondear.rounded())

        return .exito(
            Resultado(
                notaEliminada: notaEliminada,
                promedioSinRedondear: promedioSinRedondear,
                promedioFinal: promedioFinal,
                aprobado: promedioFinal >= 13
            )
        )
    }
}
