import UIKit

final class ForgotPasswordContainer {
    let input: ForgotPasswordModuleInput
	let viewController: UIViewController
	private(set) weak var router: ForgotPasswordRouterInput!

	class func assemble() -> ForgotPasswordContainer {
        let router = ForgotPasswordRouter()
        let interactor = ForgotPasswordInteractor()
        let presenter = ForgotPasswordPresenter(router: router, interactor: interactor)
		let viewController = ForgotPasswordViewController(output: presenter)

		presenter.view = viewController

		interactor.output = presenter
        router.sourceViewController = viewController

        return ForgotPasswordContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ForgotPasswordModuleInput, router: ForgotPasswordRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}
