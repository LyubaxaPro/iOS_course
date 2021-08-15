import UIKit
import PinLayout
import CoreData

final class CoreDataExampleViewController: UIViewController {
    
    private let tableView = UITableView()
    private let dataManager: CoreDataManager = CoreDataManager.shared
    private lazy var fetchedResultsController: NSFetchedResultsController<Person> = {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Person.lastName), ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let frc: NSFetchedResultsController<Person> = .init(fetchRequest: request, managedObjectContext: dataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.tableFooterView = UIView()
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        
        setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    private func setupData() {
        dataManager.initializeCoreDataIfNeeded(success: { [weak self] in
            debugPrint("Database is ready")
            self?.fetchData()
        }, failure: { error in
            debugPrint(error)
        })
    }
    
    private func fetchData() {
        try? fetchedResultsController.performFetch()
    }
    
    @objc
    private func didTapAddButton(){
        let alertVC: UIAlertController = UIAlertController(title: "Add", message: "new person", preferredStyle: .alert)
        
        alertVC.addTextField(configurationHandler: nil)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {[weak self] _ in
            guard let userInput = alertVC.textFields?.first?.text, !userInput.isEmpty else {
                return
            }
            
            let components = userInput.components(separatedBy: " ")
            
            let firstName: String = components.first ?? ""
            let lastName: String = components.last ?? ""
            
            self?.savePerson(firstName: firstName, lastName: lastName)
        }))
        
        present(alertVC, animated: true, completion: nil)

    }
    
    private func savePerson(firstName: String, lastName: String) {
        dataManager.createObject(for: Person.self) { person in
            person.firstName = firstName
            person.lastName = lastName
        }
    }
}

extension CoreDataExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell") as? PersonTableViewCell else {
            return UITableViewCell()
        }
        
        let model: Person = fetchedResultsController.object(at: indexPath)
        tableViewCell.configure(with: model.fullName)
        return tableViewCell
    }
}

extension CoreDataExampleViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        let rowAnimation = UITableView.RowAnimation.automatic
        
        switch type {
            case .insert:
                if let newIndexPath = newIndexPath {
                    tableView.insertRows(at: [newIndexPath], with: rowAnimation)
                }
                
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: rowAnimation)
                }
                    
            case .move:
                if let oldIndexPath = indexPath, let newIndexPath = newIndexPath {
                    tableView.moveRow(at: oldIndexPath, to: newIndexPath)
                }
                
            case .update:
                if let indexPath = indexPath {
                    tableView.reloadRows(at: [indexPath], with: rowAnimation)
                }
                
            @unknown default:
                break
            }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
