import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView()
    private var posts: [Post] = []
    var networkManager: NetworkManagerDescription = NetworkManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setUpActivity()
        loadPosts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
        activityIndicatorView.frame = CGRect(x: 140, y: 140, width: 40, height: 40)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        view.addSubview(tableView)
    }
    
    private func setUpActivity() {
        view.addSubview(activityIndicatorView)
    }
    
    private func loadPosts() {
        activityIndicatorView.startAnimating()
        networkManager.posts { [weak self] (result) in
            switch result {
            case .success(let posts):
                self?.posts = posts
                DispatchQueue.main.async {
                    self?.activityIndicatorView.stopAnimating()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.activityIndicatorView.stopAnimating()
                }
                print(error.localizedDescription)
            }
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        let post = posts[indexPath.row]
        cell?.textLabel?.text = post.title
        return cell ?? .init()
    }
    
}

class PostCell: UITableViewCell {
    
}
