import UIKit
import PinLayout

struct City {
    let title: String
    let temperature: Int
    let imageName: String
    let dateUpdated: Date
}

struct CityViewModel {
    let title: String
    let temperature: String
    let dateUpdated: String
    let systemImageName: String
}

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cities: [City] = [
        City(title: "Moskow", temperature: 10, imageName: "pencil", dateUpdated: Date()),
        City(title: "London", temperature: 12, imageName: "pencil", dateUpdated: Date()),
        City(title: "Paris", temperature: 10, imageName: "pencil", dateUpdated: Date()),
        City(title: "Bangkok", temperature: 20, imageName: "pencil", dateUpdated: Date()),
        City(title: "New York", temperature: 30, imageName: "pencil", dateUpdated: Date()),
        City(title: "Belgorod", temperature: 10, imageName: "pencil", dateUpdated: Date()),
        City(title: "Barnaul", temperature: 20, imageName: "pencil", dateUpdated: Date()),
        City(title: "Sochi", temperature: 35, imageName: "pencil", dateUpdated: Date()),
        City(title: "Oslo", temperature: 10, imageName: "pencil", dateUpdated: Date())
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cities"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    @objc private func didTapAdd() {
        print(#function)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? CityTableViewCell else {
            return .init()
        }
        
        cell.configure(with: cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let viewController = UIViewController()
    
        let city = cities[indexPath.row]
        viewController.title = city.title
        viewController.view.backgroundColor = .blue
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present (navigationController, animated: true, completion: nil)
    }
}


