import Foundation
import RealmSwift

class NewPerson: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
}

extension NewPerson {
    var fullName: String {
       return firstName + " " + lastName
    }
}
