import UIKit
import PinLayout

final class ForgotPasswordViewController: UIViewController {
	private let output: ForgotPasswordViewOutput
    private let infoLabel = UILabel()
    private let emailField = UITextField()
    private let resetPasswordButton = UIButton()

    init(output: ForgotPasswordViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        title = "Forgot password"
        view.backgroundColor = .white
        setupInfoLabel()
        setupEmail()
        setupResetPasswordButton()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        infoLabel.pin
            .top(view.pin.safeArea.top + 20)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(60)
        
        emailField.pin
            .below(of: infoLabel)
            .marginTop(20)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
        
        resetPasswordButton.pin
            .below(of: emailField)
            .marginTop(20)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
    }
    
    private func setupInfoLabel(){
        infoLabel.text = "Please enter your registered email to reset your password"
        infoLabel.font = .systemFont(ofSize: 17, weight: .medium)
        infoLabel.textColor = .darkGray
        infoLabel.numberOfLines = 2
        view.addSubview(infoLabel)
    }
    
    private func setupEmail() {
        emailField.placeholder = " Email"
        emailField.textColor = .black
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(emailField)
    }
    
    private func setupResetPasswordButton() {
        resetPasswordButton.backgroundColor = .systemBlue
        resetPasswordButton.setTitle("Reset password", for: .normal)
        resetPasswordButton.setTitleColor(.white, for: .normal)
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)
        view.addSubview(resetPasswordButton)
    }
    
    @objc
    private func didTapResetPassword() {
        output.didTapResetPassword(email: emailField.text ?? "")
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewInput {
}
