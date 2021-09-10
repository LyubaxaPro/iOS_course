import Foundation

protocol ForgotPasswordModuleInput {
	var moduleOutput: ForgotPasswordModuleOutput? { get }
}

protocol ForgotPasswordModuleOutput: AnyObject {
}

protocol ForgotPasswordViewInput: AnyObject {
}

protocol ForgotPasswordViewOutput: AnyObject {
    func didTapResetPassword(email: String)
}

protocol ForgotPasswordInteractorInput: AnyObject {
    func didTapResetPassword(email: String)
}

protocol ForgotPasswordInteractorOutput: AnyObject {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didResetPassword()
}

protocol ForgotPasswordRouterInput: AnyObject {
    func showAlert(error: Error, description: String)
    func showSignIn()
}
