import UIKit

class ViewControllerVenta: UIViewController {

    @IBOutlet weak var txtElectrodomestico: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtCantidad: UITextField!
    @IBOutlet weak var txtMeses: UITextField!
    @IBOutlet weak var txtInteres: UITextField!

    var subtotal: Double = 0
    var igv: Double = 0
    var base: Double = 0
    var intereses: Double = 0
    var total: Double = 0
    var cuotaMensual: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCalcular(_ sender: UIButton) {

        print("BOTON CALCULAR PRESIONADO")

        guard let precio = Double(txtPrecio.text ?? ""),
              let cantidad = Double(txtCantidad.text ?? ""),
              let meses = Double(txtMeses.text ?? ""),
              let interes = Double(txtInteres.text ?? ""),
              meses > 0 else {

            print("ERROR: DATOS INVALIDOS")
            return
        }

        subtotal = precio * cantidad
        igv = subtotal * 0.18
        base = subtotal + igv
        intereses = base * (interes / 100) * meses
        total = base + intereses
        cuotaMensual = total / meses

        print("Subtotal:", subtotal)
        print("IGV:", igv)
        print("Base:", base)
        print("Intereses:", intereses)
        print("Total:", total)
        print("Cuota mensual:", cuotaMensual)

        performSegue(withIdentifier: "irResultado", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "irResultado",
           let destino = segue.destination as? ViewControllerResultado {

            destino.subtotal = subtotal
            destino.igv = igv
            destino.base = base
            destino.intereses = intereses
            destino.total = total
            destino.cuotaMensual = cuotaMensual
        }
    }
}
