import UIKit

final class SignUpContainer {
    let input: SignUpModuleInput
	let viewController: UIViewController
	private(set) weak var router: SignUpRouterInput!

	class func assemble() -> SignUpContainer {
        let router = SignUpRouter()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter(router: router, interactor: interactor)
		let viewController = SignUpViewController(output: presenter)

		presenter.view = viewController
		//presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        router.sourceViewController = viewController
        return SignUpContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: SignUpModuleInput, router: SignUpRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

//struct SignUpContext {
//	weak var moduleOutput: SignUpModuleOutput?
//}
