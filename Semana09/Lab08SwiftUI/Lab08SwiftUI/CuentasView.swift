
import SwiftUI

struct CuentasView: View {
    // MARK: - Cuentas por cobrar
    @State private var cxcInicial: String = ""
    @State private var cxcFinal: String = ""
    @State private var ventasCredito: String = ""
    @State private var cxcVencidas: String = ""
    @State private var porcentajeIncobrabilidad: String = ""

    // MARK: - Cuentas por pagar
    @State private var cxpInicial: String = ""
    @State private var cxpFinal: String = ""
    @State private var comprasCredito: String = ""
    @State private var pasivosTotales: String = ""

    @State private var resultado: CalculadoraCuentas.Resultado?
    @State private var mensajeError: String?

    var body: some View {
        Form {
            Section("Cuentas por cobrar (CxC)") {
                TextField("Saldo inicial", text: $cxcInicial)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Saldo final", text: $cxcFinal)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Ventas a crédito", text: $ventasCredito)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Cuentas vencidas", text: $cxcVencidas)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("% incobrabilidad estimado", text: $porcentajeIncobrabilidad)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }

            Section("Cuentas por pagar (CxP)") {
                TextField("Saldo inicial", text: $cxpInicial)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Saldo final", text: $cxpFinal)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Compras a crédito", text: $comprasCredito)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Pasivos totales", text: $pasivosTotales)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }

            Section {
                Button {
                    calcular()
                } label: {
                    Text("Calcular indicadores")
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
                Section("Cuentas por cobrar") {
                    Text("Edad promedio: \(String(format: "%.2f", resultado.edadPromedioCxC)) días")
                    Text("Rotación: \(String(format: "%.2f", resultado.rotacionCxC))")
                    Text("Índice de morosidad: \(String(format: "%.2f", resultado.indiceMorosidad))%")
                    Text("Provisión de incobrables: \(String(format: "%.2f", resultado.provisionIncobrables))")
                }

                Section("Cuentas por pagar") {
                    Text("Edad promedio: \(String(format: "%.2f", resultado.edadPromedioCxP)) días")
                    Text("Rotación: \(String(format: "%.2f", resultado.rotacionCxP))")
                    Text("Índice de endeudamiento: \(String(format: "%.2f", resultado.indiceEndeudamiento))%")
                }

                Section("Ciclo financiero") {
                    Text("\(String(format: "%.2f", resultado.cicloFinanciero)) días")
                        .font(.headline)
                    Text("Una rotación mayor indica cobro o pago más rápido. Un ciclo financiero negativo significa que los proveedores financian la operación.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Cuentas por cobrar/pagar")
    }

    private func calcular() {
        guard let cxcInicialValor = Double(cxcInicial.replacingOccurrences(of: ",", with: ".")),
              let cxcFinalValor = Double(cxcFinal.replacingOccurrences(of: ",", with: ".")),
              let ventasCreditoValor = Double(ventasCredito.replacingOccurrences(of: ",", with: ".")),
              let cxcVencidasValor = Double(cxcVencidas.replacingOccurrences(of: ",", with: ".")),
              let porcentajeValor = Double(porcentajeIncobrabilidad.replacingOccurrences(of: ",", with: ".")),
              let cxpInicialValor = Double(cxpInicial.replacingOccurrences(of: ",", with: ".")),
              let cxpFinalValor = Double(cxpFinal.replacingOccurrences(of: ",", with: ".")),
              let comprasCreditoValor = Double(comprasCredito.replacingOccurrences(of: ",", with: ".")),
              let pasivosTotalesValor = Double(pasivosTotales.replacingOccurrences(of: ",", with: ".")) else {
            mensajeError = "Ingresa valores numéricos válidos en todos los campos."
            resultado = nil
            return
        }

        let entrada = CalculadoraCuentas.Entrada(
            cxcInicial: cxcInicialValor,
            cxcFinal: cxcFinalValor,
            ventasCredito: ventasCreditoValor,
            cxcVencidas: cxcVencidasValor,
            porcentajeIncobrabilidad: porcentajeValor,
            cxpInicial: cxpInicialValor,
            cxpFinal: cxpFinalValor,
            comprasCredito: comprasCreditoValor,
            pasivosTotales: pasivosTotalesValor
        )

        switch CalculadoraCuentas.calcular(entrada) {
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
        CuentasView()
    }
}
