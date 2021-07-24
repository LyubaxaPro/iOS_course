import UIKit

final class ForgotPasswordRouter {
    weak var sourceViewController: UIViewController?
}

extension ForgotPasswordRouter: ForgotPasswordRouterInput {
    func showAlert(error: Error, description: String) {
        sourceViewController?.present(AlertManager.getAlert(error: error, description: description), animated: true, completion: nil)
    }
    
    func showSignIn() {
        sourceViewController?.navigationController?.popViewController(animated: true)
    }
}
