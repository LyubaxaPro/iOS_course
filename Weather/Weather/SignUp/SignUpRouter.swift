import UIKit

final class SignUpRouter {
     weak var sourceViewController: UIViewController?
}

extension SignUpRouter: SignUpRouterInput {
    func showAlert(error: Error, description: String) {
        sourceViewController?.present(AlertManager.getAlert(error: error, description: description), animated: true, completion: nil)
    }

    func showCities() {
        let tabBarViewController = TabBarContainer.getTabBar()
        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        navigationController.setNavigationBarHidden(true, animated: true)
        sourceViewController?.view.window?.rootViewController = tabBarViewController
        sourceViewController?.view.window?.makeKeyAndVisible()
    }
}
