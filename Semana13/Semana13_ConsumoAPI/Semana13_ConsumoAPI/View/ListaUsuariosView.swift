//
//  ListaUsuariosView.swift
//  Actividad 01 — Lista de usuarios con búsqueda
//  Diseño propio: cabecera con degradado, buscador de vidrio y tarjetas con avatar
//

import SwiftUI

struct ListaUsuariosView: View {
    @StateObject private var viewModel = ListaViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Cabecera con título, chips y campo de búsqueda
                CabeceraDegradada(titulo: "Usuarios", subtitulo: "Actividad 1 · GET + búsqueda") {
                    HStack(spacing: 8) {
                        ChipDato(icono: "person.3.fill", texto: "\(viewModel.users.count) usuarios")
                        ChipDato(icono: "line.3.horizontal.decrease", texto: "\(viewModel.filteredUsers.count) visibles")
                    }
                    // Campo de búsqueda enlazado al ViewModel
                    BuscadorCapsula(texto: $viewModel.searchText, placeholder: "Buscar usuario por nombre")
                }

                // Lista de usuarios filtrados
                List(viewModel.filteredUsers) { user in
                    FilaUsuario(id: user.id, nombre: user.name)   // Solo el nombre
                        .filaTarjeta()
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .overlay {
                    if viewModel.filteredUsers.isEmpty && !viewModel.searchText.isEmpty {
                        ContentUnavailableView.search(text: viewModel.searchText)
                    }
                }
            }
            .background(Paleta.fondo.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                // Llama a fetchUsers() del ViewModel, que hace la petición a la API
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    ListaUsuariosView()
}
