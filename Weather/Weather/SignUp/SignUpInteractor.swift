import Foundation

final class SignUpInteractor {
	weak var output: SignUpInteractorOutput?
    let manager: SignUpManagerDescription = FirebaseSignUpManager.shared
}

extension SignUpInteractor: SignUpInteractorInput {
    func signUp(userInfo: UserInfo) {
        manager.signUp(userInfo: userInfo){[weak self] (error) in
            if let error = error {
                self?.output?.didReceiveErrorInteractor(error: error, description: "Sign up error")
            }
            self?.output?.didSignUp()
        }
    }
}
