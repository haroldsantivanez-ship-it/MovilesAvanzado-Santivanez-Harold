//
//  AuthView.swift
//  Lab14IntroFirebase — Actividad 02: autenticación + mensajes con Firestore
//  Diseño propio: fondo oscuro, tarjeta de vidrio y aviso tipo HUD
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertIsError = false
    @State private var authStateListener: AuthStateDidChangeListenerHandle?

    @FocusState private var campoActivo: Campo?
    enum Campo { case email, password }

    var body: some View {
        NavigationStack {
            ZStack {
                FondoFuturista()

                if isSignedIn {
                    // Show MessagesView when signed in
                    MessagesView()
                } else {
                    VStack(spacing: 28) {
                        Spacer(minLength: 20)

                        // Logo y título
                        VStack(spacing: 14) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 38, weight: .bold))
                                .foregroundStyle(Neon.degradado)
                                .frame(width: 86, height: 86)
                                .background(.white.opacity(0.06), in: Circle())
                                .overlay(Circle().stroke(.white.opacity(0.15), lineWidth: 1))
                            Text("LAB 14")
                                .font(.system(size: 13, weight: .bold, design: .monospaced))
                                .tracking(6)
                                .foregroundStyle(.white.opacity(0.55))
                            Text("Firebase")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }

                        // Sign in form
                        VStack(spacing: 16) {
                            CampoNeon(icono: "at", activo: campoActivo == .email) {
                                TextField("", text: $email,
                                          prompt: Text("Email").foregroundColor(.white.opacity(0.4)))
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .keyboardType(.emailAddress)
                                    .focused($campoActivo, equals: .email)
                            }
                            CampoNeon(icono: "lock.fill", activo: campoActivo == .password) {
                                SecureField("", text: $password,
                                            prompt: Text("Password").foregroundColor(.white.opacity(0.4)))
                                    .textContentType(.oneTimeCode)
                                    .focused($campoActivo, equals: .password)
                            }

                            VStack(spacing: 12) {
                                Button("Sign In") {
                                    signIn()
                                }
                                .buttonStyle(PrimaryButtonStyle())

                                Button("Sign Up") {
                                    signUp()
                                }
                                .buttonStyle(SecondaryButtonStyle())
                            }
                            .padding(.top, 6)
                        }
                        .padding(22)
                        .vidrio()
                        .padding(.horizontal, 24)

                        Spacer()

                        Text("Secured by Firebase Authentication")
                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.35))
                    }
                }

                // Aviso tipo HUD en lugar del alert del sistema
                if showAlert {
                    AvisoHUD(mensaje: alertMessage, esError: alertIsError) {
                        withAnimation(.spring) { showAlert = false }
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .animation(.spring(duration: 0.35), value: showAlert)
        .animation(.easeInOut, value: isSignedIn)
        .onAppear {
            checkAuthState()
        }
        .onDisappear {
            // Se quita el listener para no dejarlo activo
            if let handle = authStateListener {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
        .onChange(of: isSignedIn) {
            // Clear form when signing out
            if !isSignedIn {
                email = ""
                password = ""
            }
        }
    }

    // MARK: - Authentication Functions

    func signIn() {
        guard !email.isEmpty && !password.isEmpty else {
            mostrarAviso("Please enter both email and password", error: true)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                mostrarAviso("Sign in failed: \(error.localizedDescription)", error: true)
                print("error.localizedDescription: '\(error.localizedDescription)'")
            } else {
                isSignedIn = true
                mostrarAviso("Sign in successful!", error: false)
            }
        }
    }

    func signUp() {
        guard !email.isEmpty && !password.isEmpty else {
            mostrarAviso("Please enter both email and password", error: true)
            return
        }
        guard password.count >= 6 else {
            mostrarAviso("Password must be at least 6 characters", error: true)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                mostrarAviso("Sign up failed: \(error.localizedDescription)", error: true)
            } else {
                isSignedIn = true
                mostrarAviso("Account created successfully!", error: false)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
            mostrarAviso("Signed out successfully", error: false)
        } catch {
            mostrarAviso("Sign out failed: \(error.localizedDescription)", error: true)
        }
    }

    func checkAuthState() {
        // Listen for authentication state changes and store the listener handle
        authStateListener = Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.async {
                self.isSignedIn = user != nil
            }
        }
    }

    // Muestra el aviso (alertMessage + showAlert) indicando si es error o no
    private func mostrarAviso(_ mensaje: String, error: Bool) {
        alertMessage = mensaje
        alertIsError = error
        showAlert = true
    }
}

#Preview {
    AuthView()
}
