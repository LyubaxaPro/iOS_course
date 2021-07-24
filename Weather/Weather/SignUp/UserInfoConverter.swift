import Foundation
import Firebase

final class UserInfoConverter {
    enum Key: String{
        case firstname
        case lastname
        case identifier
    }
    
    static func dict(from userModel: UserModel) -> [String : Any] {
        var data: [String : Any] = [:]
        data[Key.firstname.rawValue] = userModel.firstname
        data[Key.lastname.rawValue] = userModel.lastname
        data[Key.identifier.rawValue] = userModel.identifier
        return data
    }
    
    static func userModel(from data: [String : Any]) -> UserModel? {
        guard let firstname = data[Key.firstname.rawValue] as? String else {
            return nil
        }
        
        guard let lastname = data[Key.lastname.rawValue] as? String else {
            return nil
        }
        
        guard let identifier = data[Key.identifier.rawValue] as? String else {
            return nil
        }
       
        let user = UserModel(firstname: firstname, lastname: lastname, identifier: identifier)
        return user
    }
}
