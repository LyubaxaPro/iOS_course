import Foundation
import Firebase

protocol AuthManagerDescription: AnyObject {
    func signIn(email: String, password: String, complition: @escaping (Error?) -> Void)
}

final class FirebaseManager: AuthManagerDescription{
    static let shared: AuthManagerDescription = FirebaseManager()
    init(){}
    
    func signIn(email: String, password: String, complition: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {(aythResult, error) in
            if let error = error {
                complition(error)
                return
            }
        }
        complition(nil)
    }
}
