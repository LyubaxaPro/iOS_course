import Foundation

final class AuthChoiseInteractor {
    weak var output: AuthChoiseInteractorOutput?
    let authManager: AuthManagerDescription = FirebaseManager.shared
}

extension AuthChoiseInteractor: AuthChoiseInteractorInput {
    func signIn(email: String, password: String) {
        authManager.signIn(email: email, password: password) {[weak self] (error) in
            if error != nil {
                self?.output?.didReceiveErrorInteractor(error: NetworkError.unexpected, description: "Sign in error")
                return
            } else {
                self?.output?.didSignIn()
            }
        }
    }
}
