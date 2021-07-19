import Foundation

protocol AuthChoiseModuleInput {
    var moduleOutput: AuthChoiseModuleOutput? { get }
}

protocol AuthChoiseModuleOutput: class {
}

protocol AuthChoiseViewInput: class {
}

protocol AuthChoiseViewOutput: class {
    func didTapSignUp(email: String, password: String)
    func didTapSignIn(email: String, password: String)
    func didReceiveError(error: Error, description: String)
}

protocol AuthChoiseInteractorInput: class {
    func signUp(email: String, password: String)
    func signIn(email: String, password: String)
}

protocol AuthChoiseInteractorOutput: class {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didSignIn()
}

protocol AuthChoiseRouterInput: class {
    func showAlert(error: Error, description: String)
    func showCities()
}
