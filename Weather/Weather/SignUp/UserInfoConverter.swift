import Foundation
import Firebase

final class UserInfoConverter {
    enum Key: String{
        case firstname
        case lastname
        case indentifier
    }
    
    static func dict(from userModel: UserModel) -> [String: Any] {
        var data: [String : Any] = [:]
        data[Key.firstname.rawValue] = userModel.firstname
        data[Key.lastname.rawValue] = userModel.lastname
        data[Key.indentifier.rawValue] = userModel.indentifier
        return data
    }
}
