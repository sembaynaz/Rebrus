    //
    //  LoginViewController.swift
    //  Rebrus
    //
    //

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        return imageView
    }()
    
    private let emailTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Адрес электронной почты".localized(from: .onboard))
        textfield.placeholder = "Введите e-mail".localized(from: .auth)
        return textfield
    }()
    
    private let passwordTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль".localized(from: .onboard))
        textfield.placeholder = "Введите пароль".localized(from: .onboard)
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let loginButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Войти в систему".localized(from: .onboard), for: .normal)
        return button
    }()
    
    private let stackHLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.isHidden = true
        return stack
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitle("Забыли пароль?".localized(from: .auth), for: .normal)
        button.setTitleColor(ColorManager.black, for: .normal)
        return button
    }()
    
    private let newUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Новый пользователь?".localized(from: .auth)
        label.textColor = ColorManager.black
        return label
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        button.setTitle("Создать аккаунт".localized(from: .auth), for: .normal)
        button.setTitleColor(ColorManager.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        navigationController?.customize()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
}

extension LoginViewController {
    private func setupConstraints() {
        setLogoImageView()
        setEmailTextField()
        setPasswordTextField()
        setErrorLabel()
        setLoginButton()
        setForgotPasswordButton()
        setCreateNewUser()
    }
    
    private func setLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(243)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalToSuperview().inset(166)
        }
    }
    private func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(96)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
    }
    private func setPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
    }
    
    private func setErrorLabel() {
        view.addSubview(stackHLabel)
        stackHLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
            make.centerX.equalTo(view.snp.centerX)
            make.horizontalEdges.equalToSuperview().inset(33)
        }
        
        let errorImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "error")
            return imageView
        }()
        
        let errorLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Montserrat-Regular", size: 10)
            label.text = "Неверный пароль. Пожалуйста, проверьте пароль.".localized(from: .auth)
            label.textColor = ColorManager.red
            return label
        }()
        
        errorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(17)
        }
        
        stackHLabel.addArrangedSubview(errorImageView)
        stackHLabel.addArrangedSubview(errorLabel)
    }
    
    private func setLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(52)
            make.top.equalTo(stackHLabel.snp.bottom).offset(22)
        }
    }
    
    private func setForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(loginButton.snp.bottom).offset(27)
            make.height.equalTo(14)
            make.width.equalTo(200)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setCreateNewUser() {
        let stackVLabel: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 5
            stack.alignment = .center
            return stack
        }()
        
        view.addSubview(stackVLabel)
        stackVLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(23)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        stackVLabel.addArrangedSubview(newUserLabel)
        stackVLabel.addArrangedSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.height.equalTo(14)
        }
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
}

extension LoginViewController {
    @objc func signupButtonTapped() {
        let vc = UINavigationController(rootViewController: SignupViewController())
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    @objc func loginButtonTapped() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request(Configuration.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { [weak self] response in
            guard let self = self else {return}
            
            var resultString = ""
            
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
            }
            
            print(response.response?.statusCode)
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                let json = JSON(response.data!)
                
                if let number = json["access_token"].string {
                    UserDefaults.standard.setValue(number, forKey: "accessToken")
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true)
                }
            } else {
                var ErrorString = "CONNECTION_ERROR"
                if let sCode = response.response?.statusCode {
                    switch sCode {
                    case 401:
                        ErrorString += "Unauthorized"
                    case 403:
                        ErrorString += "Forbidden"
                    case 404:
                        ErrorString += "Not found"
                    default:
                        ErrorString += "Қате формат"
                    }
                }
                ErrorString += " \(resultString)"
            }
        }
    }
    
    @objc func forgotPasswordButtonTapped() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
