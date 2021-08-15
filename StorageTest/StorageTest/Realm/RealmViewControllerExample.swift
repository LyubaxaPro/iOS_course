import UIKit
import PinLayout
import RealmSwift

final class RealmExampleViewController: UIViewController {
    
    private let tableView = UITableView()
    // очередь которая возвращает изменения в конкретном массиве данных
    private var notificationToken: NotificationToken?
    
    private var dataSource: Results<NewPerson>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        fetchData()
        
        notificationToken = dataSource.observe({ [weak self] changes in
            switch changes {
            case let .initial(results):
                self?.dataSource = results
            case let .update(_, deletions, insertions, modifications):
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                
                self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                
                self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self?.tableView.endUpdates()
            case let .error(error):
                fatalError(error.localizedDescription)
            }
            
        })
        
        tableView.tableFooterView = UIView()
        
        tableView.register(NewPersonTableViewCell.self, forCellReuseIdentifier: "NewPersonTableViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }

    private func fetchData() {
        dataSource = try? Realm().objects(NewPerson.self).sorted(byKeyPath: #keyPath(NewPerson.firstName), ascending: true)
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
        let realm = dataSource.realm
        
        let person:NewPerson = NewPerson()
        person.firstName = firstName
        person.lastName = lastName
        
        try? realm?.write({
            realm?.add(person)
        })
    }
}

extension RealmExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewPersonTableViewCell") as? NewPersonTableViewCell else {
            return UITableViewCell()
        }
        
        let model: NewPerson = dataSource[indexPath.row]
        tableViewCell.configure(with: model.fullName)
        return tableViewCell
    }
}

