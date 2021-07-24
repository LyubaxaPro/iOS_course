import Foundation

final class ProfilePresenter {
    weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?

    private let router: ProfileRouterInput
    private let interactor: ProfileInteractorInput
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func viewDidLoad() {
        interactor.getUserData()
    }
    
    func didTapSignOut() {
        interactor.signOut()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func setUserData(userModel: UserModel) {
        view?.setUserData(userModel: userModel)
    }
    
    func didSignOut() {
        router.signOut()
    }
    
    func didReceiveErrorInteractor(error: Error, description: String) {
        router.showAlert(error: error, description: description)
    }
}
