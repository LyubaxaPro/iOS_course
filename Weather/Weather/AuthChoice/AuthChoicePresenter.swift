import Foundation

final class AuthChoisePresenter {
    weak var view: AuthChoiseViewInput?
    weak var moduleOutput: AuthChoiseModuleOutput?

    private let router: AuthChoiseRouterInput
    private let interactor: AuthChoiseInteractorInput

    init(router: AuthChoiseRouterInput, interactor: AuthChoiseInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthChoisePresenter: AuthChoiseModuleInput {
}

extension AuthChoisePresenter: AuthChoiseViewOutput {
    func didTapSignIn(email: String, password: String) {
        if (email.isEmpty || password.isEmpty) {
            router.showAlert(error: NetworkError.unexpected, description: "miss data")
            return
        }
        interactor.signIn(email: email, password: password)
    }
    
    func didTapSignUp(email: String, password: String) {
        router.signUp()
    }
    
    func didReceiveError(error: Error, description: String) {
        router.showAlert(error: error, description: description)
    }
}

extension AuthChoisePresenter: AuthChoiseInteractorOutput {
    func didReceiveErrorInteractor(error: Error, description: String) {
        router.showAlert(error: error, description: description)
    }
    
    func didSignIn() {
        router.showCities()
    }
}

