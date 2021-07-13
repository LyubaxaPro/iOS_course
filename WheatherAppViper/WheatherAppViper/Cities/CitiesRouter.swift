import UIKit

final class CitiesRouter {
    weak var sourceViewController: UIViewController?
}

extension CitiesRouter: CitiesRouterInput {
    func showCity(model: CityViewModel) {
        let viewController = UIViewController()

        viewController.title = model.title
        viewController.view.backgroundColor = .blue
        let navigationController = UINavigationController(rootViewController: viewController)
        
        sourceViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    func openCities() {
        let container = CitiesModuleContainer.assemble()
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
