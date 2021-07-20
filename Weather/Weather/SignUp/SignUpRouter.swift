import UIKit

final class SignUpRouter {
     weak var sourceViewController: UIViewController?
}

extension SignUpRouter: SignUpRouterInput {
    func showAlert(error: Error, description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
         })
        alert.addAction(ok)
        sourceViewController?.present(alert, animated: true, completion: nil)
    }

    func showCities() {
        let tabBarViewController = TabBarContainer.getTabBar()
        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        navigationController.setNavigationBarHidden(true, animated: true)
        sourceViewController?.view.window?.rootViewController = tabBarViewController
        sourceViewController?.view.window?.makeKeyAndVisible()
    }
}
