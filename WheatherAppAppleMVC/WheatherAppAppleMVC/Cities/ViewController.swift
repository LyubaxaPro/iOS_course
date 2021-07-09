import UIKit

struct CityViewModel {
    let title: String
    let temperature: String
    let dateUpdated: String
    let imageName: String
    let description: String
}

class ViewController: UIViewController {
    
    private let model = CitiesModel()
    private var userString: String = "Don't use"
    private var cityServiceInfos: [CityServiceInfo] = [
        CityServiceInfo(name: "Moskow", id: "524901"),
        CityServiceInfo(name: "Tambov", id: "484646"),
        CityServiceInfo(name: "Cheboksary", id: "569696")
    ]
    
    private let tableView = UITableView()
    private var citiesViewModels: [CityViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = userString
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
       // let detailViewiewController = DetailViewController(city: citiesViewModels[indexPath.row], output: self)
        let detailViewiewController = DetailViewControllerClosure(city: citiesViewModels[indexPath.row])
        detailViewiewController.closure = { [weak self] text in
                    self?.title = text
        }
        navigationController?.pushViewController(detailViewiewController, animated: true)
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
                                 imageName: city.weather[0].icon,
                                 description:city.weather[0].description)
        }
        
        self.tableView.reloadData()
        
    }
}

//extension ViewController: DetailViewControllerOutput {
//    func setUserResponce(userString: String) {
//        self.userString = userString
//        self.title = userString
//        print("AAAAAAAAA I HAVE")
//        print(userString)
//    }
//
//}
