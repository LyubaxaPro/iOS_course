import Foundation

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: class {
}

protocol ProfileViewInput: class {
}

protocol ProfileViewOutput: class {
    func didTapSignOut()
}

protocol ProfileInteractorInput: class {
    func signOut()
}

protocol ProfileInteractorOutput: class {
    func didSignOut()
    func didReceiveErrorInteractor(error: Error, description: String)
}

protocol ProfileRouterInput: class {
    func showAlert(error: Error, description: String)
    func signOut()
}
