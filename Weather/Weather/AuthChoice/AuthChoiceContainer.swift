import UIKit

final class AuthChoiseContainer {
    let input: AuthChoiseModuleInput
    let viewController: UIViewController
    private(set) weak var router: AuthChoiseRouterInput!

    class func assemble() -> AuthChoiseContainer {
        let router = AuthChoiseRouter()
        let interactor = AuthChoiseInteractor()
        let presenter = AuthChoisePresenter(router: router, interactor: interactor)
        let viewController = AuthChoiseViewController(output: presenter)
        router.sourceViewController = viewController
        presenter.view = viewController
        interactor.output = presenter

        return AuthChoiseContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: AuthChoiseModuleInput, router: AuthChoiseRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

