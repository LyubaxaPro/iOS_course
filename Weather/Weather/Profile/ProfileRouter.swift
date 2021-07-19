import UIKit

final class ProfileRouter {
    weak var sourceViewController: UIViewController?
}

extension ProfileRouter: ProfileRouterInput {
    func signOut() {
        let authModuleContainer = AuthChoiseContainer.assemble()
        let authChoiceViewControllerFromContainer = authModuleContainer.viewController
        let authChoiceViewController = UINavigationController(rootViewController: authChoiceViewControllerFromContainer)
        sourceViewController?.view.window?.rootViewController = authChoiceViewController
        sourceViewController?.view.window?.makeKeyAndVisible()
    }
    
    func showAlert(error: Error, description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
         })
        alert.addAction(ok)
        sourceViewController?.present(alert, animated: true, completion: nil)
    }
}
