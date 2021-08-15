import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let dataBaseName: String = "DataBase"
    
    var context: NSManagedObjectContext {
        return storeContainer.viewContext
    }
    
    private let storeContainer: NSPersistentContainer
    private var isReady: Bool = false
    private init (){
        self.storeContainer = NSPersistentContainer(name: dataBaseName)
        self.context.automaticallyMergesChangesFromParent = true
    }
    
    func initializeCoreDataIfNeeded(success: (() -> Void)?, failure: @escaping (Error) -> Void){
        guard !isReady else {
            return
        }
        storeContainer.loadPersistentStores {[weak self] (_, error) in
            if let error = error {
                failure(error)
                return
            }
        
            self?.isReady = true
            success?()
        }
    }
    
    func fetchPerson() -> [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()

        let sortDescription = NSSortDescriptor(key: #keyPath(Person.lastName), ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescription]
        let objects = try? context.fetch(fetchRequest)
        return objects ?? []
    }
    
    func fetch<T>(with request: NSFetchRequest<T>) -> [T] {
        let objects: [T]? = try? context.fetch(request)
        return objects ?? []
    }
    
    func createObject<T: NSManagedObject>(for entity: T.Type, configurationBlock: ((T) -> Void)?) {
        let entityName: String = String(describing: entity)
        
        try? storeContainer.performBackgroundTask{ localContext in
            guard let objc = NSEntityDescription.insertNewObject(forEntityName: entityName, into: localContext) as? T else {
                return
            }
            
            configurationBlock?(objc)
            try? localContext.save()
        }
    }
    
    func count<T: NSManagedObject>(for request: NSFetchRequest<T>) -> Int {
        return (try? context.count(for: request)) ?? 0
    }
}
