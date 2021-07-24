import Foundation
import Firebase

protocol ProfileManagerDescription {
    func signOut(complition: @escaping (Error?)-> Void)
    func getUserData(complition: @escaping (Result<UserModel, Error>) -> Void)
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
    
    func getUserData(complition: @escaping (Result<UserModel, Error>) -> Void) {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        guard let currentUser = Auth.auth().currentUser else {
            complition(.failure(NetworkError.unexpected))
            return
        }
        usersRef.whereField("identifier", isEqualTo: currentUser.uid).getDocuments(){(querySnapshot, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                complition(.failure(NetworkError.unexpected))
                return
            }
            
            if documents.count != 1 {
                complition(.failure(NetworkError.unexpected))
                return
            }
            

            guard let userData: UserModel = UserInfoConverter.userModel(from: documents[0].data()) else {
                complition(.failure(NetworkError.unexpected))
                return
            }

            complition(.success(userData))
        }
    }
}
