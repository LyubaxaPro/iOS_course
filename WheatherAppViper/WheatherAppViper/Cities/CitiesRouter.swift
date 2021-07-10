import UIKit

final class CitiesRouter {
    weak var sourceViewController: UIViewController?
}

extension CitiesRouter: CitiesRouterInput {
    func openCities() {
        let container = CitiesModuleContainer.assemble()
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
