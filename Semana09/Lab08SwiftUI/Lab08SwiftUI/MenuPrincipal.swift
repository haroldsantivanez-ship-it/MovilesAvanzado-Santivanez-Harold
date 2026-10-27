import SwiftUI

struct MenuPrincipal: View {

    var body: some View {

        NavigationStack {

            List {

                NavigationLink {
                    ContentView()
                } label: {
                    Label(
                        "Actividad 01 – Stacks",
                        systemImage: "square.stack.3d.up.fill"
                    )
                }

                NavigationLink {
                    Ventana02()
                } label: {
                    Label(
                        "Ventana 02 – Contenedores",
                        systemImage: "person.crop.circle.fill"
                    )
                }

                NavigationLink {
                    Ventana03()
                } label: {
                    Label(
                        "Ventana 03 – Peso ideal",
                        systemImage: "scalemass.fill"
                    )
                }

                NavigationLink {
                    NotasView()
                } label: {
                    Label(
                        "Promedio de notas",
                        systemImage: "checklist"
                    )
                }

                NavigationLink {
                    CTSView()
                } label: {
                    Label(
                        "Calculadora de CTS",
                        systemImage: "banknote.fill"
                    )
                }

                NavigationLink {
                    GratificacionView()
                } label: {
                    Label(
                        "Calculadora de Gratificación",
                        systemImage: "giftcard.fill"
                    )
                }

                NavigationLink {
                    PagoInstructoresView()
                } label: {
                    Label(
                        "Pago de instructores",
                        systemImage: "person.text.rectangle.fill"
                    )
                }

                NavigationLink {
                    CuentasView()
                } label: {
                    Label(
                        "Cuentas por cobrar y pagar",
                        systemImage: "chart.bar.doc.horizontal.fill"
                    )
                }
            }

            .navigationTitle("Lab08 SwiftUI")
        }
    }
}

#Preview {
    MenuPrincipal()
}
