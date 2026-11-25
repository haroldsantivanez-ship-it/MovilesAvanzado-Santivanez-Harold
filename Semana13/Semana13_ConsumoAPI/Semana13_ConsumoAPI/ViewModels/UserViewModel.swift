//
//  UserViewModel.swift
//  Actividad 02 — Lógica y consumo de la API (GET, POST, PUT, DELETE)
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var searchText: String = ""

    private let baseURL = "https://jsonplaceholder.typicode.com/users"

    // Filtra por nombre o por email
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
    func fetchUsers() {
        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedUsers
                    }
                }
            }
        }.resume()
    }

    // POST: Crear un nuevo usuario
    func createUser(name: String, email: String) {
        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let newUser = User(id: 0, name: name, email: email) // id lo ignora el servidor

        do {
            request.httpBody = try JSONEncoder().encode(newUser)
        } catch {
            print("Error al codificar el usuario")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let createdUser = try? JSONDecoder().decode(User.self, from: data) {
                    DispatchQueue.main.async {
                        // JSONPlaceholder siempre responde id = 11; para no repetir ids
                        // en la lista se asigna el siguiente id disponible.
                        let nuevoId = (self.users.map(\.id).max() ?? 0) + 1
                        let usuario = User(id: nuevoId, name: createdUser.name, email: createdUser.email)
                        self.users.insert(usuario, at: 0)   // aparece primero en la lista
                        print("Usuario creado (respuesta del servidor id: \(createdUser.id))")
                    }
                }
            }
        }.resume()
    }

    // PUT: Actualizar un usuario existente  (TO DO resuelto)
    func updateUser(user: User) {
        guard let url = URL(string: "\(baseURL)/\(user.id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            print("Error al codificar el usuario")
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error al actualizar: \(error)")
                return
            }
            DispatchQueue.main.async {
                if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                    self.users[index] = user
                    print("Usuario actualizado localmente.")
                } else {
                    print("Usuario no encontrado para actualizar.")
                }
            }
        }.resume()
    }

    // DELETE: Eliminar un usuario por id
    func deleteUser(id: Int) {
        guard let url = URL(string: "\(baseURL)/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                self.users.removeAll { $0.id == id }
                print("Usuario eliminado localmente (simulado)")
            }
        }.resume()
    }
}
