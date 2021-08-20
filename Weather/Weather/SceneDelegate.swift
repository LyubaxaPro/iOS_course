import UIKit
import Firebase
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var deeplinkManager: DeeplinkManagerDescription = DeeplinkManager.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let authModuleContainer = AuthChoiseContainer.assemble()
        let authChoiceViewControllerFromContainer = authModuleContainer.viewController
        let authChoiceViewController = UINavigationController(rootViewController: authChoiceViewControllerFromContainer)
        window.rootViewController = authChoiceViewController
        deeplinkManager.navigationController = authChoiceViewController
        
        if Auth.auth().currentUser != nil {
            let tabBarViewController = TabBarContainer.getTabBar()
            let navigationController = UINavigationController(rootViewController: tabBarViewController)
            navigationController.setNavigationBarHidden(true, animated: true)
            window.rootViewController = navigationController
            deeplinkManager.navigationController = navigationController
        }
        
        window.makeKeyAndVisible()
        self.window = window
        UNUserNotificationCenter.current().delegate = self
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print(#function)
        if let url = URLContexts.first?.url {
            deeplinkManager.process(url: url)
        }
    }
    
}

extension SceneDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .list, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let url = response.notification.request.content.userInfo["url"] as? String {
            deeplinkManager.process(url: URL(string: url))
        }
        completionHandler()
    }
}

