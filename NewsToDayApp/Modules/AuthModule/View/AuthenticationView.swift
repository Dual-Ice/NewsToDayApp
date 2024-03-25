//
//  AuthenticationView.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 24.03.2024.
//

import UIKit

protocol AuthenticationViewDelegate: AnyObject {
    
    func handleLoginButtonTap(
        with request: LoginUserRequest
    )
    func handleRegisterButtonTap(
        with request: RegisterUserRequest
    )
    func showLoginAlert(for: AuthAlertManager.LoginAlert)
    func showRegisterAlert(for: AuthAlertManager.RegisterAlert)
}

final class AuthenticationView: CustomView {
    
    enum State {
        case login
        case register
    }
    
    weak var delegate: AuthenticationViewDelegate?
    
    private var viewState: State = .login {
        didSet { setupViews() }
    }

    private lazy var userNameTextField = TextFieldFactory
        .makeTextField(placeholder: "Username", image: UIImage.Icons.userBasic)
    
    private lazy var emailTextField = TextFieldFactory
        .makeTextField(placeholder: "Email Adress", image: UIImage.Icons.emailBasic)

    private lazy var passwordTextField = TextFieldFactory
        .makeSecureTextField(placeholder: "Password", image: UIImage.Icons.passwordBasic)
    
    private lazy var repeatPasswordTextField = TextFieldFactory
        .makeSecureTextField(placeholder: "Repeat Password", image: UIImage.Icons.passwordBasic)
    
    private lazy var loginButton: UIButton = {
        let button = ButtonsFactory.makeButton()
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(makeRequest), for: .touchUpInside)
        return button
    }()
    
    private lazy var haveAnAccountLabel: UILabel = {
        let label = LabelsFactory.makeTextLabel()
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        [userNameTextField,
         emailTextField,
         passwordTextField,
         repeatPasswordTextField,
         loginButton].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    override func setViews() {
        super.setViews()
        
        addSubview(haveAnAccountLabel)
        addSubview(stackView)
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    override func layoutViews() {
        haveAnAccountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        stackView.arrangedSubviews.forEach{
            $0.snp.makeConstraints { $0.height.equalTo(56) }
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(100)
        }
        setupViews()
    }
    
    private func makeLabelTappable() {
        if haveAnAccountLabel.gestureRecognizers != nil {
            haveAnAccountLabel.gestureRecognizers?.removeAll()
        }
        
        var text = ""
        var tappableText = ""
                
        switch viewState {
        case .login:
            text = "Don't have an account? Sign up!"
            tappableText = "Sign up!"
        case .register:
            text = "Already have an account? Sign in!"
            tappableText = "Sign in!"
        }
        
        let color = UIColor(
            named: ConstColors.purplePrimary
        ) ?? UIColor.systemBlue
        let attributedString = NSMutableAttributedString(string: text)
        let tappableRange = (text as NSString).range(of: tappableText)
        attributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: color,
            range: tappableRange
        )
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(haveAnAccountLabelTapped)
        )
        tapRecognizer.isEnabled = true
        tapRecognizer.numberOfTapsRequired = 1
        
        haveAnAccountLabel.attributedText = attributedString
        haveAnAccountLabel.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupViews() {
        switch viewState {
        case .login:
            setupLoginViews()
        case .register:
            setupRegisterViews()
        }
        
        makeLabelTappable()
    }
    
    private func setupLoginViews() {
        UIView.animate(withDuration: 0.3) { [self] in
            userNameTextField.isHidden = true
            userNameTextField.alpha = 0
            
            repeatPasswordTextField.isHidden = true
            repeatPasswordTextField.alpha = 0
            
            loginButton.setTitle("Sign In", for: .normal)
        } completion: { [self] completed in
            userNameTextField.text = ""
            repeatPasswordTextField.text = ""
        }
    }
    
    private func setupRegisterViews() {
        UIView.animate(withDuration: 0.3) { [self] in
            userNameTextField.isHidden = false
            userNameTextField.alpha = 1
            
            repeatPasswordTextField.isHidden = false
            repeatPasswordTextField.alpha = 1
            
            loginButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    private func makeRegisterRequest() {
        let username = userNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatedPassword = repeatPasswordTextField.text ?? ""
        
        if !ValidationManager.isValidDisplayName(username) {
            delegate?.showRegisterAlert(for: .invalidUsername)
            return
        }
        
        if !ValidationManager.isValidEmail(email) {
            delegate?.showRegisterAlert(for: .invalidEmail)
            return
        }
        
        if !ValidationManager.isValidPassword(password) {
            delegate?.showRegisterAlert(for: .invalidPassword)
            return
        }
                
        if password != repeatedPassword {
            delegate?.showRegisterAlert(for: .passwordsMismatch)
            return
        }
        
        let request = RegisterUserRequest(
            username: username,
            email: email,
            password: password
        )
        
        delegate?.handleRegisterButtonTap(with: request)
    }
    
    private func makeLoginRequest() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !ValidationManager.isValidPassword(password) {
            delegate?.showLoginAlert(for: .invalidEmailOrPassword)
            return
        }
        
        let request = LoginUserRequest(
            email: email,
            password: password
        )
        
        delegate?.handleLoginButtonTap(with: request)
    }
    
    @objc private func haveAnAccountLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = haveAnAccountLabel.text else { return }
        
        var tappableText = ""
                
        switch viewState {
        case .login:
            tappableText = "Sign up!"
        case .register:
            tappableText = "Sign in!"
        }
        
        let tappableRange = (text as NSString).range(of: tappableText)
        if gesture.didTapAttributedTextIn(
            label: haveAnAccountLabel,
            inRange: tappableRange
        ) {
            switch viewState {
            case .login:
                viewState = .register
            case .register:
                viewState = .login
            }
        } else {
            return
        }
    }
    
    @objc private func makeRequest() {
        switch viewState {
        case .login:
            makeLoginRequest()
        case .register:
            makeRegisterRequest()
        }
    }
}

extension AuthenticationView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === userNameTextField {
            textField.setIcon(UIImage.Icons.userEditing)
        }
        if textField === emailTextField {
            textField.setIcon(UIImage.Icons.emailEditing)
        }
        if textField === passwordTextField || textField === repeatPasswordTextField {
            textField.setIcon(UIImage.Icons.passwordEditing)
        }
        
        guard let textField = textField as? BaseTextField else { return }
        textField.modify()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === userNameTextField {
            textField.setIcon(UIImage.Icons.userBasic)
        }
        if textField === emailTextField {
            textField.setIcon(UIImage.Icons.emailBasic)
        }
        if textField === passwordTextField || textField === repeatPasswordTextField {
            textField.setIcon(UIImage.Icons.passwordBasic)
            textField.isSecureTextEntry = true
        }
        guard let textField = textField as? BaseTextField else { return }
        textField.modify()
    }
}
