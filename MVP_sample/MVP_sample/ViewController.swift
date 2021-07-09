import UIKit

class ViewController: UIViewController {
    let greetingLabel = UILabel()
    let greetingButton = UIButton()
    lazy var presenter: GreetingPresenterProtocol? = GreetingPresenter(view: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingLabel.text = "Default text"
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        greetingButton.addTarget(self, action: #selector(userDidTapButton), for: .touchUpInside)
        greetingButton.setTitle("Press me", for: .normal)
        greetingButton.translatesAutoresizingMaskIntoConstraints = false
        greetingButton.backgroundColor = .green
            
        view.addSubview(greetingLabel)
        view.addSubview(greetingButton)
    }
    
    override func viewDidLayoutSubviews() {
        greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        greetingLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50).isActive = true
        greetingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        greetingButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
    }
    
    @objc private func userDidTapButton(){
        self.presenter?.didGreetingButtonTap()
    }
}

extension ViewController: GreetingViewProtocol {
    func setNewGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
}
