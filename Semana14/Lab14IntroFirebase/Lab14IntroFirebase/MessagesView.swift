//
//  MessagesView.swift
//  Lab14IntroFirebase — Actividad 02: chat en tiempo real
//  Diseño propio: cabecera de vidrio con indicador LIVE, burbujas y barra de envío flotante
//

import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var databaseService = DatabaseService()
    @State private var newMessage = ""
    @State private var pulso = false
    @FocusState private var escribiendo: Bool

    private var miEmail: String { Auth.auth().currentUser?.email ?? "" }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 12) {
                Text(inicial(miEmail))
                    .font(.system(.headline, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Neon.degradado, in: Circle())

                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text("Messages")
                            .font(.system(.title3, design: .rounded).weight(.bold))
                            .foregroundStyle(.white)
                        Circle()
                            .fill(Neon.verde)
                            .frame(width: 7, height: 7)
                            .opacity(pulso ? 1 : 0.3)
                        Text("LIVE")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundStyle(Neon.verde)
                    }
                    Text(miEmail)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.55))
                        .lineLimit(1)
                }

                Spacer()

                Button {
                    try? Auth.auth().signOut()
                } label: {
                    Image(systemName: "power")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Neon.magenta)
                        .frame(width: 40, height: 40)
                        .background(.white.opacity(0.06), in: Circle())
                        .overlay(Circle().stroke(.white.opacity(0.12), lineWidth: 1))
                }
                .accessibilityLabel("Sign Out")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .vidrio(radio: 24)
            .padding(.horizontal, 12)
            .padding(.top, 4)

            // Messages list
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 14) {
                        ForEach(databaseService.messages) { message in
                            BurbujaMensaje(message: message, esMio: message.userEmail == miEmail)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 18)
                }
                .scrollDismissesKeyboard(.interactively)
                .overlay {
                    if databaseService.messages.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "dot.radiowaves.left.and.right")
                                .font(.system(size: 40))
                                .foregroundStyle(Neon.degradado)
                            Text("Canal vacío")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.white)
                            Text("Envía el primer mensaje")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                }
                // Baja al último mensaje cuando llega uno nuevo
                .onChange(of: databaseService.messages.count) {
                    if let ultimo = databaseService.messages.last {
                        withAnimation { proxy.scrollTo(ultimo.id, anchor: .bottom) }
                    }
                }
            }

            // New message input
            HStack(spacing: 10) {
                TextField("", text: $newMessage,
                          prompt: Text("Type a message...").foregroundColor(.white.opacity(0.4)),
                          axis: .vertical)
                    .lineLimit(1...4)
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.white)
                    .tint(Neon.cian)
                    .focused($escribiendo)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 13)

                Button {
                    if !newMessage.isEmpty {
                        databaseService.addMessage(text: newMessage)
                        newMessage = ""
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 46, height: 46)
                        .background(Neon.degradado, in: Circle())
                        .opacity(newMessage.isEmpty ? 0.4 : 1)
                }
                .disabled(newMessage.isEmpty)
                .padding(.trailing, 6)
            }
            .vidrio(radio: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Neon.cian.opacity(0.6), lineWidth: escribiendo ? 1 : 0)
            )
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
        }
        .onAppear {
            databaseService.startListening()
            withAnimation(.easeInOut(duration: 1).repeatForever()) { pulso = true }
        }
        .onDisappear {
            databaseService.stopListening()
        }
    }
}

// MARK: - Burbuja de mensaje

struct BurbujaMensaje: View {
    let message: Message
    let esMio: Bool

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if esMio { Spacer(minLength: 50) }

            if !esMio {
                Text(inicial(message.userEmail))
                    .font(.system(.caption, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(.white.opacity(0.12), in: Circle())
            }

            VStack(alignment: esMio ? .trailing : .leading, spacing: 6) {
                if !esMio {
                    Text(message.userEmail)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(Neon.cian)
                }
                Text(message.text)
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.white)
                Text(message.timestamp, style: .time)
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.55))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background {
                if esMio {
                    UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20,
                                           bottomTrailingRadius: 6, topTrailingRadius: 20, style: .continuous)
                        .fill(Neon.violeta.opacity(0.85))
                } else {
                    UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 6,
                                           bottomTrailingRadius: 20, topTrailingRadius: 20, style: .continuous)
                        .fill(.white.opacity(0.08))
                        .overlay(
                            UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 6,
                                                   bottomTrailingRadius: 20, topTrailingRadius: 20, style: .continuous)
                                .stroke(.white.opacity(0.15), lineWidth: 1)
                        )
                }
            }

            if !esMio { Spacer(minLength: 50) }
        }
    }
}
