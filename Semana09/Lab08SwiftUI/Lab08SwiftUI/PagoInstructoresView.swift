
import SwiftUI

struct PagoInstructoresView: View {
    @State private var horasSemanales: String = ""
    @State private var sistema: CalculadoraPagoInstructores.SistemaPensiones = .afp
    @State private var resultado: CalculadoraPagoInstructores.Resultado?
    @State private var mensajeError: String?

    var body: some View {
        Form {
            Section("Datos del instructor") {
                TextField("Horas semanales (1-23)", text: $horasSemanales)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)

                Picker("Sistema de pensiones", selection: $sistema) {
                    ForEach(CalculadoraPagoInstructores.SistemaPensiones.allCases) { opcion in
                        Text(opcion.rawValue).tag(opcion)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section {
                Button {
                    calcular()
                } label: {
                    Text("Calcular pago")
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
                    Text("Sueldo bruto mensual: \(String(format: "%.2f", resultado.bruto))")
                    Text("Aporte pensionario: \(String(format: "%.2f", resultado.aportePensionario))")
                    Text("Renta bruta anual proyectada: \(String(format: "%.2f", resultado.rentaBrutaAnual))")
                    Text("Renta neta anual: \(String(format: "%.2f", resultado.rentaNetaAnual))")
                    Text("IR mensual: \(String(format: "%.2f", resultado.irMensual))")
                    Text("EsSalud (aporte del empleador): \(String(format: "%.2f", resultado.esSalud))")
                    Text("Sueldo neto: \(String(format: "%.2f", resultado.neto))")
                        .font(.headline)
                }

                Section {
                    Text("Nota: el Impuesto a la Renta de 5ta categoría es una proyección simplificada para fines del laboratorio.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Pago de instructores")
    }

    private func calcular() {
        guard let horasValor = Int(horasSemanales) else {
            mensajeError = "Ingresa un número entero de horas semanales."
            resultado = nil
            return
        }

        switch CalculadoraPagoInstructores.calcular(horasSemanales: horasValor, sistema: sistema) {
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
        PagoInstructoresView()
    }
}
