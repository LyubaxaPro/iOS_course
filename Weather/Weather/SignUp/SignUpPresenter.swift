import Foundation

final class SignUpPresenter {
	weak var view: SignUpViewInput?
    weak var moduleOutput: SignUpModuleOutput?

	private let router: SignUpRouterInput
	private let interactor: SignUpInteractorInput

    init(router: SignUpRouterInput, interactor: SignUpInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func checkEmail(email: String) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )
        return result != nil
    }
}

extension SignUpPresenter: SignUpModuleInput {
}

extension SignUpPresenter: SignUpViewOutput {
    func didTapSignUp(userInfo: UserInfo){
        if (userInfo.firstname.isEmpty || userInfo.lastname.isEmpty || userInfo.email.isEmpty || userInfo.password.isEmpty) {
            router.showAlert(error: NetworkError.unexpected, description: "Miss data")
        }
        
        guard checkEmail(email: userInfo.email) else {
            router.showAlert(error: NetworkError.unexpected, description: "Wrong email")
            return
        }
        
        interactor.signUp(userInfo: userInfo)
        
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
    func didReceiveErrorInteractor(error: Error, description: String) {
        router.showAlert(error: error, description: description)
    }
    
    func didSignUp() {
        router.showCities()
    }
}
