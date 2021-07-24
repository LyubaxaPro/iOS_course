import Foundation
import Firebase

protocol ForgotPasswordManagerDescription: AnyObject {
    func resetPassword(email: String, complition: @escaping (Error?) -> Void)
}

class FirebaseForgotPasswordManager: ForgotPasswordManagerDescription {
    static let shared: ForgotPasswordManagerDescription = FirebaseForgotPasswordManager()
    
    init(){}
    func resetPassword(email: String, complition: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email){ (error) in
            if error != nil {
                complition(error)
                return
            }
            complition(nil)
        }
    }
}
