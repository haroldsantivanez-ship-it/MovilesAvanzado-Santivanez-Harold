//
//  UserFormView.swift
//  Semana13_ConsumoAPI — Formulario para agregar o modificar un usuario
//  Diseño propio: avatar en vivo, campos con ícono y botón con degradado
//

import SwiftUI

struct UserFormView: View {
    @Environment(\.dismiss) private var dismiss

    @State var name: String
    @State var email: String
    var isEditing: Bool
    var onSubmit: (String, String) -> Void

    // El email debe tener @ y punto; el nombre no puede estar vacío
    private var formularioValido: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") && email.contains(".")
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    // Avatar que cambia mientras se escribe el nombre
                    VStack(spacing: 10) {
                        AvatarUsuario(id: name.count, nombre: name.isEmpty ? "?" : name, tamano: 88)
                            .shadow(color: Paleta.indigo.opacity(0.25), radius: 16, y: 8)
                        Text(isEditing ? "Editando usuario" : "Nuevo usuario")
                            .font(.system(.title2, design: .rounded).weight(.bold))
                        Text(isEditing ? "Se enviará con el método PUT" : "Se enviará con el método POST")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 12)

                    VStack(spacing: 12) {
                        campo(icono: "person.fill", titulo: "Nombre") {
                            TextField("Ej. Harold Santivañez", text: $name)
                        }
                        campo(icono: "envelope.fill", titulo: "Email") {
                            TextField("correo@ejemplo.com", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        }
                    }

                    Button {
                        onSubmit(name, email)
                        dismiss()
                    } label: {
                        Label(isEditing ? "Guardar cambios" : "Crear usuario",
                              systemImage: isEditing ? "checkmark.circle.fill" : "plus.circle.fill")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Paleta.degradado, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .opacity(formularioValido ? 1 : 0.45)
                    }
                    .disabled(!formularioValido)
                }
                .padding(20)
            }
            .background(Paleta.fondo.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }

    // Campo con ícono, etiqueta y fondo de tarjeta
    private func campo<Contenido: View>(icono: String, titulo: String,
                                        @ViewBuilder contenido: () -> Contenido) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icono)
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(Paleta.degradado, in: RoundedRectangle(cornerRadius: 11, style: .continuous))
            VStack(alignment: .leading, spacing: 2) {
                Text(titulo.uppercased())
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
                contenido()
                    .font(.body)
            }
        }
        .padding(14)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: Paleta.indigo.opacity(0.06), radius: 10, y: 4)
    }
}
