import Foundation

protocol ForgotPasswordModuleInput {
	var moduleOutput: ForgotPasswordModuleOutput? { get }
}

protocol ForgotPasswordModuleOutput: class {
}

protocol ForgotPasswordViewInput: class {
}

protocol ForgotPasswordViewOutput: class {
    func didTapResetPassword(email: String)
}

protocol ForgotPasswordInteractorInput: class {
    func didTapResetPassword(email: String)
}

protocol ForgotPasswordInteractorOutput: class {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didResetPassword()
}

protocol ForgotPasswordRouterInput: class {
    func showAlert(error: Error, description: String)
    func showSignIn()
}
