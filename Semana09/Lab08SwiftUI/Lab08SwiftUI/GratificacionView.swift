import SwiftUI

struct GratificacionView: View {
    @State private var remuneracion: String = ""
    @State private var mesesTrabajados: String = ""
    @State private var resultado: CalculadoraGratificacion.Resultado?
    @State private var mensajeError: String?

    var body: some View {
        Form {
            Section("Datos del trabajador") {
                TextField("Remuneración mensual", text: $remuneracion)
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
                    Text("Calcular gratificación")
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
                    Text("Remuneración: S/ \(String(format: "%.2f", resultado.remuneracionComputable))")
                    
                    Text("Meses trabajados: \(resultado.mesesTrabajados)")
                    
                    Text("Gratificación: S/ \(String(format: "%.2f", resultado.gratificacion))")
                        .font(.headline)
                }

                Section("Fórmula aplicada") {
                    Text("(Remuneración / 6) × Meses trabajados")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Gratificación")
    }

    private func calcular() {
        guard let remuneracionValor = Double(
            remuneracion.replacingOccurrences(of: ",", with: ".")
        ),
        let mesesValor = Int(mesesTrabajados) else {
            mensajeError = "Ingresa valores numéricos válidos."
            resultado = nil
            return
        }

        switch CalculadoraGratificacion.calcular(
            remuneracionComputable: remuneracionValor,
            mesesTrabajados: mesesValor
        ) {
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
        GratificacionView()
    }
}
