import Foundation
import Firebase

protocol ProfileManagerDescription {
    func signOut(complition: @escaping (Error?)-> Void)
}

class FirebaseProfileManager: ProfileManagerDescription {
    static let shared: ProfileManagerDescription = FirebaseProfileManager()
    private init(){}
    func signOut(complition: @escaping (Error?) -> Void) {
        do {
        try Auth.auth().signOut()
        complition(nil)
        return
        } catch {
            complition(error)
            return
        }
    }
}
