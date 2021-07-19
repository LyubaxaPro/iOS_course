import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        let window = UIWindow(windowScene: windowScene)

        let authModuleContainer = AuthChoiseContainer.assemble()
        let authChoiceViewControllerFromContainer = authModuleContainer.viewController
        let authChoiceViewController = UINavigationController(rootViewController: authChoiceViewControllerFromContainer)
        window.rootViewController = authChoiceViewController
        
        if Auth.auth().currentUser != nil {
            let tabBarViewController = TabBarContainer.getTabBar()
            let navigationController = UINavigationController(rootViewController: tabBarViewController)
            navigationController.setNavigationBarHidden(true, animated: true)
            window.rootViewController = navigationController
        }
        window.makeKeyAndVisible()
        self.window = window
    }
}

