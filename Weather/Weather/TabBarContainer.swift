import UIKit

final class TabBarContainer{
    class func getTabBar() -> UITabBarController{
        let tabBarViewController = UITabBarController()
        
        let citiesModuleContainer = CitiesModuleContainer.assemble()
        let citiesViewControllerFromContainer = citiesModuleContainer.viewController
        let citiesViewController = UINavigationController(rootViewController: citiesViewControllerFromContainer)
        
        let mapModuleContainer = MapContainer.assemble()
        let mapViewControllerFromContainer = mapModuleContainer.viewController
        let mapViewController = UINavigationController(rootViewController: mapViewControllerFromContainer)
        
        let profileModuleContainer = ProfileContainer.assemble()
        let profileViewControllerFromContainer = profileModuleContainer.viewController
        let profileViewController = UINavigationController(rootViewController: profileViewControllerFromContainer)
        
        citiesViewController.title = "Погода"
        mapViewController.title = "Карта"
        profileViewController.title = "Профиль"
        
        tabBarViewController.setViewControllers([citiesViewController, mapViewController, profileViewController], animated: false)
        
        guard let items = tabBarViewController.tabBar.items else {
            return UITabBarController()
        }
        
        let images = ["calendar", "map", "person.crop.circle"]
        for i in 0..<items.count  {
            items[i].image = UIImage(systemName: images[i])
        }
        
        return tabBarViewController
    }
}
