import Foundation

protocol SignUpModuleInput {
	var moduleOutput: SignUpModuleOutput? { get }
}

protocol SignUpModuleOutput: class {
}

protocol SignUpViewInput: class {
}

protocol SignUpViewOutput: class {
    func didTapSignUp(userInfo: UserInfo)
}

protocol SignUpInteractorInput: class {
    func signUp(userInfo: UserInfo)
}

protocol SignUpInteractorOutput: class {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didSignUp()
}

protocol SignUpRouterInput: class {
    func showAlert(error: Error, description: String)
    func showCities()
}
