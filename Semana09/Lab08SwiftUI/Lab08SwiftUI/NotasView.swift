
import SwiftUI

struct NotasView: View {
    @State private var nota1: String = ""
    @State private var nota2: String = ""
    @State private var nota3: String = ""
    @State private var nota4: String = ""
    @State private var resultado: CalculadoraNotas.Resultado?
    @State private var mensajeError: String?

    var body: some View {
        Form {
            Section("Notas de teoría (0-20 o AN)") {
                TextField("Nota 1", text: $nota1)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)

                TextField("Nota 2", text: $nota2)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)

                TextField("Nota 3", text: $nota3)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)

                TextField("Nota 4", text: $nota4)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)
            }

            Section {
                Button {
                    calcular()
                } label: {
                    Text("Calcular promedio")
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
                    Text("Nota eliminada: \(resultado.notaEliminada)")
                    Text("Promedio sin redondear: \(String(format: "%.2f", resultado.promedioSinRedondear))")
                    Text("Promedio final: \(resultado.promedioFinal)")
                    Text(resultado.aprobado ? "Estado: Aprobado" : "Estado: Desaprobado")
                        .font(.headline)
                        .foregroundStyle(resultado.aprobado ? .green : .red)
                }
            }
        }
        .navigationTitle("Promedio de notas")
    }

    private func calcular() {
        switch CalculadoraNotas.calcular(notas: [nota1, nota2, nota3, nota4]) {
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
        NotasView()
    }
}
