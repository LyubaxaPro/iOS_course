import UIKit
import PinLayout

final class AuthChoiseViewController: UIViewController {
    private let output: AuthChoiseViewOutput
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let passwordIcon = UIImageView()
    private let signupButton = UIButton()

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
        setupSignupButton()
        //setupSignUpButton()
        setupPasswordIcon()
        view.backgroundColor = .white
    }
    
    private func setupEmail() {
        emailField.placeholder = " Email"
        emailField.textColor = .black
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(emailField)
    }
    
    private func setupSignInButton() {
        signInButton.backgroundColor = .systemRed
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        view.addSubview(signInButton)
    }
    
//    private func setupSignUpButton() {
//        signUpButton.backgroundColor = .systemGray
//        signUpButton.setTitle("Sign up", for: .normal)
//        signUpButton.setTitleColor(.white, for: .normal)
//        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
//    }
    
    private func setupSignupButton() {
        signupButton.backgroundColor = .systemGray
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        view.addSubview(signupButton)
    }
    
    private func setupPassword() {
        passwordField.placeholder = " Password"
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(passwordField)
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
        
        signupButton.pin
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
        output.didTapSignUp(email: emailField.text ?? "", password: passwordField.text ?? "")
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
        output.didTapSignIn(email: emailField.text ?? "", password: passwordField.text ?? "")
        emailField.text = ""
        passwordField.text = ""
    }
}

extension AuthChoiseViewController: AuthChoiseViewInput {
}
