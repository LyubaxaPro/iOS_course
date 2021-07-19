import Foundation

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
    let profileManager: ProfileManagerDescription = FirebaseProfileManager.shared
}

extension ProfileInteractor: ProfileInteractorInput {
    func signOut() {
        profileManager.signOut(){[weak self] (error) in
            if error != nil {
                self?.output?.didReceiveErrorInteractor(error: error ?? NetworkError.unexpected, description: "Sign out error")
            } else {
                self?.output?.didSignOut()
            }
        }
    }
}
