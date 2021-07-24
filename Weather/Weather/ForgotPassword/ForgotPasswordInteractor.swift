import Foundation

final class ForgotPasswordInteractor {
	weak var output: ForgotPasswordInteractorOutput?
    let manager: ForgotPasswordManagerDescription? = FirebaseForgotPasswordManager.shared
}

extension ForgotPasswordInteractor: ForgotPasswordInteractorInput {
    func didTapResetPassword(email: String) {
        if email.isEmpty {
            output?.didReceiveErrorInteractor(error: NetworkError.unexpected, description: "Miss email data")
            return
        }
        manager?.resetPassword(email: email) { [weak self] (error) in
            if let error = error {
                self?.output?.didReceiveErrorInteractor(error: error, description: "Wrong email")
                return
            } else {
                self?.output?.didResetPassword()
            }
        }
    }
}
