import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
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

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        setupSignOutButton()
    }
    
    override func viewDidLayoutSubviews() {
        signOutButton.pin
            .bottom(view.pin.safeArea.bottom + 20)
            .right(5)
            .left(5)
            .height(40)
    }
    
    @objc
    func didTapSignOut() {
        output.didTapSignOut()
    }
}

extension ProfileViewController: ProfileViewInput {
}
