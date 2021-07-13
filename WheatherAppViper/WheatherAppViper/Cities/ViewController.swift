import UIKit

struct CityViewModel {
    let title: String
    let temperature: String
    let dateUpdated: String
    let systemImageName: String
}

class ViewController: UIViewController {
    
    private let tableView = UITableView()
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
        
        view.addSubview(tableView)
        
        output.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    @objc private func didTapAdd() {
        output.didTapAddButton()
    }
    
    @objc private func didPullRefresh(){
        output.didPullRefresh()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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

extension ViewController: CitiesViewInput {
    func reloadData() {
        tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
}
