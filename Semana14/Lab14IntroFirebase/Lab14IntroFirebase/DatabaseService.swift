//
//  DatabaseService.swift
//  Lab14IntroFirebase — Actividad 02: mensajes en Cloud Firestore
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService: ObservableObject {

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?      // para no abrir dos escuchas a la vez
    @Published var messages: [Message] = []

    // Add a message to database
    func addMessage(text: String) {

        guard let user = Auth.auth().currentUser else { return }

        let message = Message(
            id: UUID().uuidString,
            text: text,
            userEmail: user.email ?? "Unknown",
            timestamp: Date()
        )

        do {
            print("message \(message.userEmail)")
            try db.collection("messages").document(message.id).setData(from: message)
        } catch {
            print("Error adding message: \(error)")
        }
    }

    // Listen for real-time updates
    func startListening() {
        guard listener == nil else { return }
        listener = db.collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting messages: \(error)")
                    return
                }

                self.messages = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Message.self)
                } ?? []
            }
    }

    // Deja de escuchar cuando se cierra la vista
    func stopListening() {
        listener?.remove()
        listener = nil
    }
}

// Message data model
struct Message: Identifiable, Codable {
    let id: String
    let text: String
    let userEmail: String
    let timestamp: Date
}
