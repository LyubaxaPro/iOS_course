import Foundation

protocol AuthChoiseModuleInput {
    var moduleOutput: AuthChoiseModuleOutput? { get }
}

protocol AuthChoiseModuleOutput: class {
}

protocol AuthChoiseViewInput: class {
}

protocol AuthChoiseViewOutput: class {
    func didTapSignIn(email: String, password: String)
    func didTapSignUp()
    func didTapForgotPassword()
}

protocol AuthChoiseInteractorInput: class {
    func signIn(email: String, password: String)
}

protocol AuthChoiseInteractorOutput: class {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didSignIn()
}

protocol AuthChoiseRouterInput: class {
    func showAlert(error: Error, description: String)
    func showCities()
    func signUp()
    func didTapForgotPassword()
}
