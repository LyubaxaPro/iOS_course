import UIKit

final class CitiesModuleContainer {
    
    let viewController: UIViewController
    
    
    private init (viewController: UIViewController) {
        self.viewController = viewController
    }
    
    class func assemble() -> CitiesModuleContainer {
        let interactor = CitiesInteractor()
        let router = CitiesRouter()
        let presenter = CitiesPresenter(interactor: interactor, router: router)
        let viewController = ViewController(output: presenter)
        router.sourceViewController = viewController
        presenter.view = viewController
        interactor.output = presenter
        
        
        return CitiesModuleContainer(viewController: viewController)
    }
}
