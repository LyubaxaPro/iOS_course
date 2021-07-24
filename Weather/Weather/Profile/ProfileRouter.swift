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
        sourceViewController?.present(AlertManager.getAlert(error: error, description: description), animated: true, completion: nil)
    }
}
