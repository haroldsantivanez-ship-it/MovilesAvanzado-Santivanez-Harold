
import SwiftUI

// MARK: - CalculadoraPesoIdeal

struct CalculadoraPesoIdeal {
    enum Genero: String, CaseIterable, Identifiable {
        case hombre = "Hombre"
        case mujer = "Mujer"

        var id: String { rawValue }
    }

    static func calcular(alturaCm: Double, genero: Genero) -> Double {
        switch genero {
        case .hombre:
            return 50 + 0.9 * (alturaCm - 152)
        case .mujer:
            return 45.5 + 0.9 * (alturaCm - 152)
        }
    }
}

// MARK: - Ventana03

struct Ventana03: View {
    @State private var altura: String = ""
    @State private var edad: String = ""
    @State private var genero: CalculadoraPesoIdeal.Genero = .hombre
    @State private var pesoIdeal: Double?
    @State private var mensajeError: String?

    var body: some View {
        Form {
            Section("Datos personales") {
                TextField("Altura (cm)", text: $altura)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)

                TextField("Edad (opcional)", text: $edad)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)

                Picker("Género", selection: $genero) {
                    ForEach(CalculadoraPesoIdeal.Genero.allCases) { opcion in
                        Text(opcion.rawValue).tag(opcion)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section {
                Button {
                    calcular()
                } label: {
                    Text("Calcular peso ideal")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }

            if let mensajeError {
                Section {
                    Text(mensajeError)
                        .foregroundStyle(.red)
                }
            }

            if let pesoIdeal {
                Section("Resultado") {
                    Text("Peso Ideal: \(String(format: "%.1f", pesoIdeal)) kg")
                        .font(.title3.bold())
                }
            }

            Section {
                Text("Desarrollado por: Diego Nina Malqui")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Ventana 03")
    }

    private func calcular() {
        guard let alturaCm = Double(altura.replacingOccurrences(of: ",", with: ".")), alturaCm > 0 else {
            mensajeError = "Ingresa una altura numérica mayor que 0."
            pesoIdeal = nil
            return
        }

        mensajeError = nil
        pesoIdeal = CalculadoraPesoIdeal.calcular(alturaCm: alturaCm, genero: genero)
    }
}

#Preview {
    NavigationStack {
        Ventana03()
    }
}
