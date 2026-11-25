//
//  ListaViewModel.swift
//  Actividad 01 — Lista de usuarios con búsqueda (GET con dataTask)
//

import Foundation

// ViewModel para manejar la lógica de red y los datos de usuarios
class ListaViewModel: ObservableObject {

    // Publica la lista de usuarios para que la vista se actualice automáticamente
    @Published var users: [User] = []
    @Published var searchText: String = ""        // Texto del filtro

    // Computed property que filtra los usuarios según el texto ingresado
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    // Función que obtiene los usuarios desde una API externa
    func fetchUsers() {
        // Se asegura de que la URL sea válida
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("URL inválida")
            return
        }
        // Inicia una tarea de red para obtener datos desde la URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Decodifica los datos JSON en un arreglo de objetos 'User'
                    let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                    // Actualiza 'users' en el hilo principal para que la vista se refresque
                    DispatchQueue.main.async {
                        self.users = decodedUsers
                    }
                } catch {
                    print("Error al decodificar: \(error)")
                }
            } else if let error = error {
                print("Error de red: \(error)")
            }
        }.resume() // ¡No olvidar llamar a resume() para que la tarea se ejecute!
    }
}
