import UIKit

struct CityViewModel {
    let title: String
    let temperature: String
    let dateUpdated: String
    let systemImageName: String
}

class ViewController: UIViewController {
    
    private let model = CitiesModel()
    private var cityServiceInfos: [CityServiceInfo] = [
        CityServiceInfo(name: "Moskow", id: "524901"),
        CityServiceInfo(name: "Tambov", id: "484646"),
        CityServiceInfo(name: "Cheboksary", id: "569696")
    ]
    
    private let tableView = UITableView()
    private var citiesViewModels: [CityViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cities"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .none
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        view.addSubview(tableView)
        
        model.load(cities: cityServiceInfos)
        model.output = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    @objc private func didTapAdd() {
//        let city = City(title: "New City", temperature: 36, imageName: "pencil", dateUpdated: Date())
//        cities.insert(city, at: 0)
        tableView.reloadData()
    }
    
    @objc private func didPullRefresh(){
        model.load(cities: cityServiceInfos)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? CityTableViewCell else {
            return .init()
        }
        
        cell.configure(with: citiesViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let viewController = UIViewController()
    
        let city = citiesViewModels[indexPath.row]
        viewController.title = city.title
        viewController.view.backgroundColor = .blue
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present (navigationController, animated: true, completion: nil)
    }
}

extension ViewController: CitiesModelOutput{
    func didLoad(cities: [CityResponse]){
        tableView.refreshControl?.endRefreshing()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        self.citiesViewModels = cities.map { city in
            return CityViewModel(title: city.name,
                                 temperature: String(Int(round(city.main.temp))),
                                 dateUpdated: dateFormatter.string(from: Date()),
                                 systemImageName: "pencil")
        }
        
        self.tableView.reloadData()
        
    }
}
