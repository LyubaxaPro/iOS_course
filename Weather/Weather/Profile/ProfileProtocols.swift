import Foundation

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func setUserData(userModel: UserModel)
}

protocol ProfileViewOutput: AnyObject {
    func didTapSignOut()
    func viewDidLoad()
}

protocol ProfileInteractorInput: AnyObject {
    func signOut()
    func getUserData()
}

protocol ProfileInteractorOutput: AnyObject {
    func didSignOut()
    func didReceiveErrorInteractor(error: Error, description: String)
    func setUserData(userModel: UserModel)
    
}

protocol ProfileRouterInput: AnyObject {
    func showAlert(error: Error, description: String)
    func signOut()
}
