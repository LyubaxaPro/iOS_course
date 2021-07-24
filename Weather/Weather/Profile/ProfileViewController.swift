import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    private var firstnameLabel = UILabel()
    private var userFirstName = UILabel()
    private var userLastName = UILabel()
    private var lastnameLabel = UILabel()
    let signOutButton = UIButton()

    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    func setupSignOutButton() {
        signOutButton.backgroundColor = .yellow
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setTitleColor(.black, for: .normal)
        signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    
    private func setupLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        view.addSubview(label)
        return label
    }
    
    private func setupUserLable(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        view.addSubview(label)
        return label
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        
        setupSignOutButton()
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        signOutButton.pin
            .bottom(view.pin.safeArea.bottom + 20)
            .right(5)
            .left(5)
            .height(40)
        
        firstnameLabel.pin
            .top(view.pin.safeArea.top + 10)
            .left(view.pin.safeArea.left + 5)
            .sizeToFit()
        
        userFirstName.pin
            .top(view.pin.safeArea.top + 10)
            .after(of: firstnameLabel)
            .marginLeft(20)
            .right(view.pin.safeArea.right + 5)
            .sizeToFit()
        
        lastnameLabel.pin
            .below(of: firstnameLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 5)
            .sizeToFit()
        
        userLastName.pin
            .below(of: userFirstName)
            .marginTop(10)
            .after(of: lastnameLabel)
            .marginLeft(20)
            .right(view.pin.safeArea.right + 5)
            .sizeToFit()
    }
    
    @objc
    func didTapSignOut() {
        output.didTapSignOut()
    }
}

extension ProfileViewController: ProfileViewInput {
    func setUserData(userModel: UserModel) {
        userFirstName = setupUserLable(text: userModel.firstname)
        userLastName = setupUserLable(text: userModel.lastname)
        firstnameLabel = setupLabel(text: "First name:")
        lastnameLabel = setupLabel(text: "Last name:")
    }
}
