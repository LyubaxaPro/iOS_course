import Foundation

final class ForgotPasswordPresenter {
	weak var view: ForgotPasswordViewInput?
    weak var moduleOutput: ForgotPasswordModuleOutput?

	private let router: ForgotPasswordRouterInput
	private let interactor: ForgotPasswordInteractorInput

    init(router: ForgotPasswordRouterInput, interactor: ForgotPasswordInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ForgotPasswordPresenter: ForgotPasswordModuleInput {
}

extension ForgotPasswordPresenter: ForgotPasswordViewOutput {
    func didTapResetPassword(email: String) {
        interactor.didTapResetPassword(email: email)
    }
    
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutput {
    func didReceiveErrorInteractor(error: Error, description: String){
        router.showAlert(error: error, description: description)
    }
    
    
    func didResetPassword(){
        router.showSignIn()
    }
}
