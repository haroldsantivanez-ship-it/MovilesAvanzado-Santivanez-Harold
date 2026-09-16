//
//  ViewController.swift
//  CalculadoraPrestamos
//
//  Created by Tecsup on 16/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtMonto: UITextField!
    @IBOutlet weak var txtTasa: UITextField!
    @IBOutlet weak var txtPlazo: UITextField!
    @IBOutlet weak var lblResultado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func calcularPrestamo(_ sender: Any) {
        guard let monto = Double(txtMonto.text ?? ""),
              let tasaAnual = Double(txtTasa.text ?? ""),
              let plazo = Double(txtPlazo.text ?? "") else {
            lblResultado.text = "Ingrese datos válidos"
            return
        }

        let tasaMensual = (tasaAnual / 100) / 12
        let numeroPagos = plazo * 12

        let cuotaMensual = monto *
            (tasaMensual * pow(1 + tasaMensual, numeroPagos)) /
            (pow(1 + tasaMensual, numeroPagos) - 1)

        let totalPagar = cuotaMensual * numeroPagos

        lblResultado.text = String(
            format: "Cuota mensual: S/ %.2f\nTotal a pagar: S/ %.2f",
            cuotaMensual,
            totalPagar
        )
    }
}

