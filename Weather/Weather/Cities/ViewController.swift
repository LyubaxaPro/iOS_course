import UIKit

struct CityViewModel {
    let title: String
    let temperature: String
    let dateUpdated: String
    let systemImageName: String
}

class CitiesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let pushStatusBannerView = PushStatusBannerView()
    private let output: CitiesViewOutput
    
    init (output: CitiesViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        view.addSubview(pushStatusBannerView)
        view.backgroundColor = .white
        output.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pushStatusBannerView.pin
            .bottom(view.pin.safeArea.bottom)
            .horizontally(12)
            .height(64)
        
        tableView.pin
            .top()
            .horizontally()
            .above(of: pushStatusBannerView)
        
    }
    
    @objc private func didTapAdd() {
        output.didTapAddButton()
    }
    
    @objc private func didPullRefresh(){
        output.didPullRefresh()
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.citiesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? CityTableViewCell else {
            return .init()
        }
        
        cell.configure(with: output.citiesViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        output.didSelectItem(at: indexPath.row)
    }
}

extension CitiesViewController: CitiesViewInput {
    func addCities() {
        
        tableView.performBatchUpdates({
            tableView.insertRows(at: [IndexPath.init(row: output.citiesViewModels.count - 1, section: 0)], with: .automatic)
        }, completion: nil)
    }
    
    func reloadData() {
        tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func updatePushStatusBannerView(pushStatus: PushStatus) {
        pushStatusBannerView.update(with: pushStatus)
    }
}
