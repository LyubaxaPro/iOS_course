import Foundation

protocol SignUpModuleInput {
	var moduleOutput: SignUpModuleOutput? { get }
}

protocol SignUpModuleOutput: AnyObject {
}

protocol SignUpViewInput: AnyObject {
}

protocol SignUpViewOutput: AnyObject {
    func didTapSignUp(userInfo: UserInfo)
}

protocol SignUpInteractorInput: AnyObject {
    func signUp(userInfo: UserInfo)
}

protocol SignUpInteractorOutput: AnyObject {
    func didReceiveErrorInteractor(error: Error, description: String)
    func didSignUp()
}

protocol SignUpRouterInput: AnyObject {
    func showAlert(error: Error, description: String)
    func showCities()
}
