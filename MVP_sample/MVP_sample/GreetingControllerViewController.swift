import UIKit
//
//class GreetingControllerView: UIViewController {
//    let greetingLabel = UILabel()
//    let greetingButton = UIButton()
//    weak var presenter: GreetingPresenterProtocol?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        greetingLabel.text = "Default text"
//        greetingButton.addTarget(self, action: #selector(userDidTapButton), for: .touchUpInside)
//    }
//
//    override func viewDidLayoutSubviews() {
//        let constraints: [NSLayoutConstraint] = [
//            greetingLabel.topAnchor.constraint(equalTo: greetingLabel.safeAreaLayoutGuide.topAnchor, constant: 10),
//            greetingLabel.leftAnchor.constraint(equalTo: greetingLabel.safeAreaLayoutGuide.leftAnchor, constant: 50),
//            greetingButton.bottomAnchor.constraint(equalTo: greetingButton.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            greetingButton.rightAnchor.constraint(equalTo: greetingButton.safeAreaLayoutGuide.rightAnchor, constant: -15)
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
//
//    @objc private func userDidTapButton(){
//        self.presenter?.didGreetingButtonTap()
//    }
//}
//
//extension GreetingControllerView: GreetingViewProtocol {
//    func setNewGreeting(greeting: String) {
//        self.greetingLabel.text = greeting
//    }
//}
