import Foundation
import Firebase

protocol AuthManagerDescription: AnyObject {
    func signUp(email: String, password: String, complition: @escaping (Error?) -> Void)
    func signIn(email: String, password: String, complition: @escaping (Error?) -> Void)
}

final class FirebaseManager: AuthManagerDescription{
    static let shared: AuthManagerDescription = FirebaseManager()
    init(){}
    
    func signUp(email: String, password: String, complition: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let error = error {
                complition(error)
                return
            }
        }
        complition(nil)
    }
    
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
