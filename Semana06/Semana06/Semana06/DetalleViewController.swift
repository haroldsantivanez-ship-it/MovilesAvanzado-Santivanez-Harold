import UIKit

class DetalleViewController: UIViewController {

    @IBOutlet weak var lblCantidad: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cambiarCantidad(_ sender: UIStepper) {
        lblCantidad.text = "\(Int(sender.value))"
    }
}
