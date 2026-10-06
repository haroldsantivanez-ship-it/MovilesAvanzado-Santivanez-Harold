import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtNombres: UITextField!
    @IBOutlet weak var txtDNI: UITextField!

    @IBAction func btnContinuar(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? ViewControllerConfirmacion {
            destino.apellidosRecibidos = txtApellidos.text ?? ""
            destino.nombresRecibidos = txtNombres.text ?? ""
            destino.dniRecibido = txtDNI.text ?? ""
        }
    }
}
