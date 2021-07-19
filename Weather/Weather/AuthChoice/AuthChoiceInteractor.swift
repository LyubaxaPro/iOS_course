import Foundation

final class AuthChoiseInteractor {
    weak var output: AuthChoiseInteractorOutput?
    let authManager: AuthManagerDescription = FirebaseManager.shared
    func checkEmail(email: String) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )
        return result != nil
    }
    
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
    
    func signUp(email: String, password: String) {
        guard checkEmail(email: email) else {
            output?.didReceiveErrorInteractor(error: NetworkError.unexpected, description: "Not correct email")
            return
        }
        authManager.signUp(email: email, password: password) {[weak self] ( error ) in
            if error != nil {
                self?.output?.didReceiveErrorInteractor(error: NetworkError.unexpected, description: "Sign up error")
            }
        }
    }
}
