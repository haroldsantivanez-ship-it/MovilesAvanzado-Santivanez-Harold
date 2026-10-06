import UIKit

class ViewControllerResultado: UIViewController {

    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblIGV: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblIntereses: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCuotaMensual: UILabel!

    var subtotal: Double = 0
    var igv: Double = 0
    var base: Double = 0
    var intereses: Double = 0
    var total: Double = 0
    var cuotaMensual: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        lblSubtotal.text = String(format: "S/. %.2f", subtotal)
        lblIGV.text = String(format: "S/. %.2f", igv)
        lblBase.text = String(format: "S/. %.2f", base)
        lblIntereses.text = String(format: "S/. %.2f", intereses)
        lblTotal.text = String(format: "S/. %.2f", total)
        lblCuotaMensual.text = String(format: "S/. %.2f", cuotaMensual)
    }
}
