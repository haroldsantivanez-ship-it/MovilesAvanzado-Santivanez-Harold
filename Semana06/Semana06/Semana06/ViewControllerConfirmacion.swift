//
//  ViewControllerConfirmacion.swift
//  Semana06
//
//  Created by Tecsup on 30/09/26.
//

import UIKit

class ViewControllerConfirmacion: UIViewController {

    @IBOutlet weak var lblApellidos: UILabel!
    @IBOutlet weak var lblNombres: UILabel!
    @IBOutlet weak var lblDNI: UILabel!

    var apellidosRecibidos = ""
    var nombresRecibidos = ""
    var dniRecibido = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        lblApellidos.text = apellidosRecibidos
        lblNombres.text = nombresRecibidos
        lblDNI.text = dniRecibido
    }
}
