import Foundation
import SwiftData
import Observation

/// Sesión de la app: recuerda al usuario conectado mientras la app está abierta.
/// Es @Observable, así que cuando `usuario` cambia, RootView se redibuja sola
/// (muestra el TabView o vuelve al login).
@Observable
final class Sesion {
    var usuario: Usuario?

    func cerrar() {
        usuario = nil
    }
}

/// Lógica de registro y login usando FetchDescriptor + #Predicate.
enum Autenticacion {

    enum ErrorRegistro: LocalizedError {
        case camposVacios, usuarioRepetido, claveCorta, clavesDistintas

        var errorDescription: String? {
            switch self {
            case .camposVacios:    return "Completa todos los campos."
            case .usuarioRepetido: return "Ese usuario ya existe."
            case .claveCorta:      return "La clave debe tener mínimo 6 caracteres."
            case .clavesDistintas: return "Las claves no coinciden."
            }
        }
    }

    /// Normaliza el usuario: sin espacios y en minúsculas.
    /// Así "LPAREDES" y "lparedes" son el mismo usuario.
    static func normalizar(_ texto: String) -> String {
        texto.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    /// ¿Ya existe el usuario? FetchDescriptor con #Predicate y fetchCount.
    static func existeUsuario(_ usuario: String, en contexto: ModelContext) -> Bool {
        let buscado = normalizar(usuario)   // se guarda en un let ANTES del #Predicate
        let descriptor = FetchDescriptor<Usuario>(predicate: #Predicate { $0.usuario == buscado })
        return ((try? contexto.fetchCount(descriptor)) ?? 0) > 0
    }

    static func registrar(nombre: String, usuario: String, clave: String, confirmacion: String,
                          rol: String, en contexto: ModelContext) throws -> Usuario {
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        let usuarioLimpio = normalizar(usuario)

        guard !nombreLimpio.isEmpty, !usuarioLimpio.isEmpty, !clave.isEmpty else {
            throw ErrorRegistro.camposVacios
        }
        guard !existeUsuario(usuarioLimpio, en: contexto) else { throw ErrorRegistro.usuarioRepetido }
        guard clave.count >= 6 else { throw ErrorRegistro.claveCorta }
        guard clave == confirmacion else { throw ErrorRegistro.clavesDistintas }

        let nuevo = Usuario(nombre: nombreLimpio, usuario: usuarioLimpio, clave: clave, rol: rol)
        contexto.insert(nuevo)
        try contexto.save()
        return nuevo
    }

    /// Devuelve el usuario si usuario y clave coinciden; si no, nil.
    /// La vista muestra un mensaje genérico, sin decir cuál de los dos falló.
    static func login(usuario: String, clave: String, en contexto: ModelContext) -> Usuario? {
        let buscado = normalizar(usuario)
        let claveBuscada = clave
        let descriptor = FetchDescriptor<Usuario>(
            predicate: #Predicate { $0.usuario == buscado && $0.clave == claveBuscada })
        return try? contexto.fetch(descriptor).first
    }
}
