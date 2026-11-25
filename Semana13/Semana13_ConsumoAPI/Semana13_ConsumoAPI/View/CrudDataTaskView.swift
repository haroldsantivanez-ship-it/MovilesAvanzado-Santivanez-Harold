//
//  CrudDataTaskView.swift
//  Actividad 02 — GET, POST, PUT y DELETE con dataTask
//  Diseño propio: cabecera con degradado, tarjetas, swipe y botón flotante
//

import SwiftUI

struct CrudDataTaskView: View {
    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CabeceraDegradada(titulo: "Usuarios", subtitulo: "Actividad 2 · dataTask") {
                    HStack(spacing: 8) {
                        ChipDato(icono: "person.3.fill", texto: "\(viewModel.users.count) usuarios")
                        ChipDato(icono: "arrow.left.arrow.right", texto: "GET · POST · PUT · DELETE")
                    }
                    BuscadorCapsula(texto: $viewModel.searchText, placeholder: "Buscar por nombre o email")
                }

                List(viewModel.filteredUsers) { user in
                    FilaUsuario(id: user.id, nombre: user.name, email: user.email)
                        .filaTarjeta()
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteUser(id: user.id)
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
            }
            .background(Paleta.fondo.ignoresSafeArea())
            // Botón flotante para agregar
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
                viewModel.fetchUsers()
            }
            .sheet(isPresented: $showingForm) {
                if let user = editingUser {
                    UserFormView(name: user.name, email: user.email, isEditing: true) { name, email in
                        let updated = User(id: user.id, name: name, email: email)
                        viewModel.updateUser(user: updated)
                    }
                } else {
                    UserFormView(name: "", email: "", isEditing: false) { name, email in
                        viewModel.createUser(name: name, email: email)
                    }
                }
            }
        }
    }
}

#Preview {
    CrudDataTaskView()
}
