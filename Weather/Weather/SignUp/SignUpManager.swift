import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol SignUpManagerDescription: AnyObject {
    func signUp(userInfo: UserInfo, complition: @escaping (Error?) -> Void)
}

final class FirebaseSignUpManager: SignUpManagerDescription {
    static let shared: SignUpManagerDescription = FirebaseSignUpManager()
    private let database = Firestore.firestore()
    
    init(){}
    func signUp(userInfo: UserInfo, complition: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password) {(authResult, error) in
            if let error = error {
                complition(error)
                return
            } else {
                let uid = authResult?.user.uid ?? ""
                if uid.isEmpty {
                    complition(error)
                    return
                }
                let userModel = UserModel(firstname: userInfo.firstname, lastname: userInfo.lastname, identifier: uid)
                let data = UserInfoConverter.dict(from: userModel)
                self.database.collection("users").addDocument(data: data) { (error) in
                    if error != nil {
                        complition(error)
                        return
                    }
                }
                complition(nil)
            }
        }
    }
}
