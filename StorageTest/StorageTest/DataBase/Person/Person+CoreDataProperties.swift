import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var firstName: String
    @NSManaged public var lastName: String

}

extension Person {
    var fullName: String {
        return firstName + " " + lastName
    }
}

extension Person : Identifiable {

}
