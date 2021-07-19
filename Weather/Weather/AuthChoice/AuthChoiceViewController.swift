import UIKit
import PinLayout

final class AuthChoiseViewController: UIViewController {
    private let output: AuthChoiseViewOutput
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let passwordIcon = UIImageView()

    init(output: AuthChoiseViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmail()
        setupPassword()
        setupSignInButton()
        setupSignUpButton()
        setupPasswordIcon()
        view.backgroundColor = .white
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(passwordIcon)
    }
    
    private func setupEmail() {
        emailField.placeholder = "Email"
        emailField.textColor = .black
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    private func setupSignInButton() {
        signInButton.backgroundColor = .systemRed
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    private func setupSignUpButton() {
        signUpButton.backgroundColor = .systemGray
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    private func setupPassword() {
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    private func setupPasswordIcon(){
        passwordIcon.image = UIImage(named: "passwordIcon")
        passwordIcon.isUserInteractionEnabled = true
        passwordIcon.alpha = 0.1
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPasswordIcon))
        passwordIcon.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailField.pin
            .top(view.pin.safeArea.top + 30)
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
        
        signInButton.pin
            .below(of: passwordField)
            .marginTop(40)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
        
        signUpButton.pin
            .below(of: signInButton)
            .marginTop(5)
            .right(view.pin.safeArea.right + 15)
            .left(view.pin.safeArea.left + 15)
            .height(40)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func didTapSignUp() {
        guard let email = emailField.text,
              !email.isEmpty,
              let password = passwordField.text,
              !password.isEmpty else {
            output.didReceiveError(error: NetworkError.unexpected, description: "miss data")
            return
        }
        output.didTapSignUp(email: email, password: password)
        emailField.text = ""
        passwordField.text = ""
    }
    
    @objc private func didTapPasswordIcon() {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        if (passwordField.isSecureTextEntry){
            passwordIcon.alpha = 0.1
        } else {
            passwordIcon.alpha = 1
        }
    }
    
    @objc private func didTapSignIn() {
        guard let email = emailField.text,
              !email.isEmpty,
              let password = passwordField.text,
              !password.isEmpty else {
            output.didReceiveError(error: NetworkError.unexpected, description: "miss data")
            return
        }
        output.didTapSignIn(email: email, password: password)
        emailField.text = ""
        passwordField.text = ""
    }
}

extension AuthChoiseViewController: AuthChoiseViewInput {
}
