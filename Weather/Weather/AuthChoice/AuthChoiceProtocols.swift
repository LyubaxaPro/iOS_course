import Foundation

protocol AuthChoiseModuleInput {
    var moduleOutput: AuthChoiseModuleOutput? { get }
}

protocol AuthChoiseModuleOutput: AnyObject {
}

protocol AuthChoiseViewInput: AnyObject {
}

protocol AuthChoiseViewOutput: AnyObject {
    func didTapSignIn(email: String, password: String)
    func didTapSignUp()
    func didTapForgotPassword()
}

protocol AuthChoiseInteractorInput: AnyObject {
    func signIn(email: String, password: String)
}

protocol AuthChoiseInteractorOutput: AnyObject {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didSignIn()
}

protocol AuthChoiseRouterInput: AnyObject {
    func showAlert(error: Error, description: String)
    func showCities()
    func signUp()
    func didTapForgotPassword()
}
