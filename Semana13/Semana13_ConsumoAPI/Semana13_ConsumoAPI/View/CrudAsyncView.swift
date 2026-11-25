//
//  CrudAsyncView.swift
//  Actividad 03 — GET, POST, PUT y DELETE con async/await
//

import SwiftUI

struct CrudAsyncView: View {
    @StateObject private var viewModel = UserAsyncViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CabeceraDegradada(titulo: "Usuarios", subtitulo: "Actividad 3 · async / await") {
                    HStack(spacing: 8) {
                        ChipDato(icono: "person.3.fill", texto: "\(viewModel.users.count) usuarios")
                        ChipDato(icono: "bolt.fill", texto: "async / await")
                    }
                    BuscadorCapsula(texto: $viewModel.searchText, placeholder: "Buscar por nombre o email")
                }

                List(viewModel.filteredUsers) { user in
                    FilaUsuario(id: user.id, nombre: user.name, email: user.email)
                        .filaTarjeta()
                        .swipeActions {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteUser(id: user.id)
                                }
                            } label: {
                                Label("Eliminar", systemImage: "trash.fill")
                            }

                            Button {
                                editingUser = user
                                showingForm = true
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(Paleta.indigo)
                        }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 70) }
                // Deslizar hacia abajo vuelve a pedir los usuarios (también es async)
                .refreshable {
                    await viewModel.fetchUsers()
                }
                .overlay {
                    if viewModel.isLoading && viewModel.users.isEmpty {
                        ProgressView("Cargando usuarios…")
                            .padding(24)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .background(Paleta.fondo.ignoresSafeArea())
            .overlay(alignment: .bottom) {
                Button {
                    editingUser = nil
                    showingForm = true
                } label: {
                    Label("Nuevo usuario", systemImage: "plus")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 26)
                        .padding(.vertical, 16)
                        .background(Paleta.degradado, in: Capsule())
                        .shadow(color: Paleta.indigo.opacity(0.4), radius: 14, y: 8)
                }
                .padding(.bottom, 12)
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                Task {
                    await viewModel.fetchUsers()
                }
            }
            .sheet(isPresented: $showingForm) {
                if let user = editingUser {
                    UserFormView(name: user.name, email: user.email, isEditing: true) { name, email in
                        let updated = User(id: user.id, name: name, email: email)
                        Task {
                            await viewModel.updateUser(user: updated)
                        }
                    }
                } else {
                    UserFormView(name: "", email: "", isEditing: false) { name, email in
                        Task {
                            await viewModel.createUser(name: name, email: email)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CrudAsyncView()
}
