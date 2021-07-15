import UIKit

final class CityWebContainer {
    let input: CityWebModuleInput
	let viewController: UIViewController
	private(set) weak var router: CityWebRouterInput!

	class func assemble(with city: String) -> CityWebContainer {
        let router = CityWebRouter()
        let interactor = CityWebInteractor()
        let presenter = CityWebPresenter(router: router, interactor: interactor)
		let viewController = CityWebViewController(output: presenter)

		presenter.view = viewController
		//presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return CityWebContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CityWebModuleInput, router: CityWebRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

