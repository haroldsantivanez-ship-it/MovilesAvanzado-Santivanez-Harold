import Foundation

protocol Calculable {
    func calcular() -> ResultadoVenta
}

protocol Validable {
    func validar() -> Bool
}
