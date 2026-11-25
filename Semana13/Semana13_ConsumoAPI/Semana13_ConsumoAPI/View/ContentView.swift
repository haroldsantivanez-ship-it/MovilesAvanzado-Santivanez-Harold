//
//  ContentView.swift
//  Semana13_ConsumoAPI — Una sola app con las 3 actividades del laboratorio
//  Cada pestaña es una actividad
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ListaUsuariosView()
                .tabItem {
                    Label("Actividad 1", systemImage: "list.bullet.rectangle")
                }

            CrudDataTaskView()
                .tabItem {
                    Label("Actividad 2", systemImage: "arrow.left.arrow.right")
                }

            CrudAsyncView()
                .tabItem {
                    Label("Actividad 3", systemImage: "bolt.fill")
                }
        }
        .tint(Paleta.indigo)
    }
}

#Preview {
    ContentView()
}
