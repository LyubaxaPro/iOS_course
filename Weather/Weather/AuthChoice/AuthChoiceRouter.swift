import UIKit

final class AuthChoiseRouter {
    weak var sourceViewController: UIViewController?
}

extension AuthChoiseRouter: AuthChoiseRouterInput {
    func didTapForgotPassword() {
        let forgotPasswordContainer = ForgotPasswordContainer.assemble()
        sourceViewController?.navigationController?.pushViewController(forgotPasswordContainer.viewController, animated: true)
    }
    
    func signUp() {
        let signUpContainer = SignUpContainer.assemble()
        sourceViewController?.navigationController?.pushViewController(signUpContainer.viewController, animated: true)
    }
    
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
