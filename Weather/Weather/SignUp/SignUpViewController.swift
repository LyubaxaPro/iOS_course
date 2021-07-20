import UIKit
import PinLayout

final class SignUpViewController: UIViewController {
	private let output: SignUpViewOutput
    private var emailField = UITextField()
    private var passwordField = UITextField()
    private var firstnameField = UITextField()
    private var lastnameField = UITextField()
    private var signUpButton = UIButton()
    private let passwordIcon = UIImageView()

    init(output: SignUpViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(placeholder: String) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(field)
        return field
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        emailField = setup(placeholder: " Email")
        passwordField = setup(placeholder: " Password")
        passwordField.isSecureTextEntry = true
        firstnameField = setup(placeholder: " First name")
        lastnameField = setup(placeholder: " Last name")
        setupSignUpButton()
        setupPasswordIcon()
	}
    
    private func setupSignUpButton() {
        signUpButton.backgroundColor = .systemRed
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        view.addSubview(signUpButton)
    }
    
    private func setupPasswordIcon(){
        passwordIcon.image = UIImage(named: "passwordIcon")
        passwordIcon.isUserInteractionEnabled = true
        passwordIcon.alpha = 0.1
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPasswordIcon))
        passwordIcon.addGestureRecognizer(gestureRecognizer)
        view.addSubview(passwordIcon)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
            firstnameField.pin
            .top(view.pin.safeArea.top + 30)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
        
            lastnameField.pin
            .below(of: firstnameField)
            .marginTop(20)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
        
            emailField.pin
            .below(of: lastnameField)
            .marginTop(20)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
        
            passwordField.pin
            .below(of: emailField)
            .marginTop(20)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)

            passwordIcon.pin
            .below(of: emailField)
            .marginTop(20)
            .size(CGSize(width: 40, height: 40))
            .right(view.pin.safeArea.right + 15)
        
            signUpButton.pin
            .below(of: passwordField)
            .marginTop(30)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
    }

    
    @objc
    private func didTapSignUp() {
        let userInfo = UserInfo(firstname: firstnameField.text ?? "", lastname: lastnameField.text ?? "", email: emailField.text ?? "", password: passwordField.text ?? "")
        output.didTapSignUp(userInfo: userInfo)
    }
    
    @objc
    private func didTapPasswordIcon() {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        if (passwordField.isSecureTextEntry){
            passwordIcon.alpha = 0.1
        } else {
            passwordIcon.alpha = 1
        }
    }
}

extension SignUpViewController: SignUpViewInput {
}
