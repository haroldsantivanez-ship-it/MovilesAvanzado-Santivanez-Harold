
import SwiftUI

struct CTSView: View {
    @State private var sueldo: String = ""
    @State private var gratificacion: String = ""
    @State private var mesesTrabajados: String = ""
    @State private var resultado: CalculadoraCTS.Resultado?
    @State private var mensajeError: String?

    var body: some View {
        Form {
            Section("Datos del periodo semestral") {
                TextField("Sueldo mensual", text: $sueldo)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)

                TextField("Gratificación percibida", text: $gratificacion)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)

                TextField("Meses trabajados (1-6)", text: $mesesTrabajados)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }

            Section {
                Button {
                    calcular()
                } label: {
                    Text("Calcular CTS")
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

            if let resultado {
                Section("Resultado") {
                    Text("Sexto de gratificación: \(String(format: "%.2f", resultado.sextoGratificacion))")
                    Text("Remuneración computable: \(String(format: "%.2f", resultado.remuneracionComputable))")
                    Text("CTS: \(String(format: "%.2f", resultado.cts))")
                        .font(.headline)
                }
            }
        }
        .navigationTitle("Calculadora de CTS")
    }

    private func calcular() {
        guard let sueldoValor = Double(sueldo.replacingOccurrences(of: ",", with: ".")),
              let gratificacionValor = Double(gratificacion.replacingOccurrences(of: ",", with: ".")),
              let mesesValor = Int(mesesTrabajados) else {
            mensajeError = "Ingresa valores numéricos válidos en todos los campos."
            resultado = nil
            return
        }

        switch CalculadoraCTS.calcular(sueldo: sueldoValor, gratificacion: gratificacionValor, mesesTrabajados: mesesValor) {
        case .exito(let valor):
            mensajeError = nil
            resultado = valor
        case .error(let mensaje):
            mensajeError = mensaje
            resultado = nil
        }
    }
}

#Preview {
    NavigationStack {
        CTSView()
    }
}
