import UIKit

class ViewControllerVenta: UIViewController {

    @IBOutlet weak var txtElectrodomestico: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtCantidad: UITextField!
    @IBOutlet weak var txtMeses: UITextField!
    @IBOutlet weak var txtInteres: UITextField!

    var resultado: ResultadoVenta?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCalcular(_ sender: UIButton) {

        guard
            let precio = Double(txtPrecio.text ?? ""),
            let cantidad = Int(txtCantidad.text ?? ""),
            let meses = Int(txtMeses.text ?? ""),
            let interes = Double(txtInteres.text ?? "")
        else {
            return
        }

        let venta = VentaModel(
            precio: precio,
            cantidad: cantidad,
            meses: meses,
            interesMensual: interes
        )

        guard venta.validar() else {
            return
        }

        resultado = venta.calcular()

        performSegue(withIdentifier: "irResultado", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "irResultado",
           let destino = segue.destination as? ViewControllerResultado,
           let resultado = resultado {

            destino.subtotal = resultado.subtotal
            destino.igv = resultado.igv
            destino.base = resultado.base
            destino.intereses = resultado.intereses
            destino.total = resultado.total
            destino.cuotaMensual = resultado.cuotaMensual
        }
    }
}
