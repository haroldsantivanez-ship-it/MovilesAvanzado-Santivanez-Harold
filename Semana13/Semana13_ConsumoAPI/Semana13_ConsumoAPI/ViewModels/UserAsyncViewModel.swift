//
//  UserAsyncViewModel.swift
//  Actividad 03: async / await con URLSession.shared.data
//  GET  → URLSession.shared.data(from: url)
//  POST, PUT, DELETE → URLSession.shared.data(for: request)
//

import Foundation

class UserAsyncViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var searchText: String = ""
    @Published var isLoading = false          // muestra el indicador de carga

    private let baseURL = "https://jsonplaceholder.typicode.com/users"

    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.name.lowercased().contains(searchText.lowercased()) ||
                user.email.lowercased().contains(searchText.lowercased())
            }
        }
    }

    // GET: Obtener todos los usuarios
    func fetchUsers() async {
        guard let url = URL(string: baseURL) else { return }
        await MainActor.run { self.isLoading = true }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)

            await MainActor.run {
                self.users = decodedUsers
                self.isLoading = false
            }
        } catch {
            print("Error fetching users: \(error)")
            await MainActor.run { self.isLoading = false }
        }
    }

    // POST: Crear un nuevo usuario
    func createUser(name: String, email: String) async {
        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let newUser = User(id: 0, name: name, email: email) // id lo ignora el servidor

        do {
            request.httpBody = try JSONEncoder().encode(newUser)
            let (data, _) = try await URLSession.shared.data(for: request)
            let createdUser = try JSONDecoder().decode(User.self, from: data)

            await MainActor.run {
                // JSONPlaceholder siempre devuelve id 11: se usa el siguiente id libre
                let nuevoId = (self.users.map(\.id).max() ?? 0) + 1
                self.users.insert(User(id: nuevoId, name: createdUser.name, email: createdUser.email), at: 0)
            }
        } catch {
            print("Error creating user: \(error)")
        }
    }

    // PUT: Actualizar un usuario existente
    func updateUser(user: User) async {
        guard let url = URL(string: "\(baseURL)/\(user.id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
            let (_, _) = try await URLSession.shared.data(for: request)

            await MainActor.run {
                if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                    self.users[index] = user
                    print("Usuario actualizado localmente.")
                } else {
                    print("Usuario no encontrado para actualizar.")
                }
            }
        } catch {
            print("Error updating user: \(error)")
        }
    }

    // DELETE: Eliminar un usuario por id
    func deleteUser(id: Int) async {
        guard let url = URL(string: "\(baseURL)/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        do {
            let (_, _) = try await URLSession.shared.data(for: request)

            await MainActor.run {
                self.users.removeAll { $0.id == id }
                print("Usuario eliminado localmente (simulado)")
            }
        } catch {
            print("Error deleting user: \(error)")
        }
    }
}
