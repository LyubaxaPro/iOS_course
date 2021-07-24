import Foundation

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: class {
}

protocol ProfileViewInput: class {
    func setUserData(userModel: UserModel)
}

protocol ProfileViewOutput: class {
    func didTapSignOut()
    func viewDidLoad()
}

protocol ProfileInteractorInput: class {
    func signOut()
    func getUserData()
}

protocol ProfileInteractorOutput: class {
    func didSignOut()
    func didReceiveErrorInteractor(error: Error, description: String)
    func setUserData(userModel: UserModel)
    
}

protocol ProfileRouterInput: class {
    func showAlert(error: Error, description: String)
    func signOut()
}
