import UIKit

final class AlertManager{
    class func getAlert(error: Error, description: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
         })
        alert.addAction(ok)
        return alert
    }
}
