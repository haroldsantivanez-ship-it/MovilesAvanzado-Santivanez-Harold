//
//  ViewController.swift
//  CalculadoraIMC
//
//  Created by Tecsup on 16/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtPeso: UITextField!
    @IBOutlet weak var txtAltura: UITextField!
    @IBOutlet weak var lblResultado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func calcularIMC(_ sender: Any) {
        guard let pesoTexto = txtPeso.text,
              let alturaTexto = txtAltura.text,
              let peso = Double(pesoTexto),
              let altura = Double(alturaTexto),
              altura > 0 else {
            lblResultado.text = "Ingrese datos válidos"
            return
        }
        
        let imc = peso / (altura * altura)
        
        lblResultado.text = String(format: "IMC: %.2f", imc)
    }
}
