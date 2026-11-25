//
//  User.swift
//  Semana13_ConsumoAPI — Modelo
//  Utilizando los métodos POST - PUT - DELETE
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
