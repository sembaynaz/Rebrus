    //
    //  SignupViewController.swift
    //  Rebrus
    //
    //  Created by Nazerke Sembay on 19.01.2024.
    //

import UIKit
import Alamofire
import SwiftyJSON
class SignupViewController: UIViewController {
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
    
    private let codeTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Номер телефона".localized(from: .onboard))
        textfield.setTextToTextField("KZ +7")
        textfield.allowsEditingTextAttributes = false
        return textfield
    }()
    
    private let numberTextField: TextField = {
        let textfield = TextField()
        textfield.placeholder = "Введите номер телефона".localized(from: .onboard)
        textfield.setPlaceholderText("")
        return textfield
    }()
    
    private let passwordTextField1: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль".localized(from: .onboard))
        textfield.placeholder = "Введите новый пароль".localized(from: .onboard)
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let passwordTextField2: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Подтвердите пароль".localized(from: .onboard))
        textfield.placeholder = "Введите пароль повторно".localized(from: .onboard)
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let signupButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Продолжить".localized(from: .onboard), for: .normal)
        return button
    }()
    
    private let stackHLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    private let newUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Уже зарегистрировались?".localized(from: .onboard)
        label.textColor = ColorManager.black
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        button.setTitle("Войти в аккаунт".localized(from: .onboard), for: .normal)
        button.setTitleColor(ColorManager.blue, for: .normal)
        return button
    }()
    
    let criterionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.text = "должно содержать 8 символов.".localized(from: .auth)
        label.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        navigationController?.customize()
    }
}

extension SignupViewController {
    private func setupConstraints() {
        setLogoImageView()
        setEmailTextField()
        setNumberTextField()
        setPasswordTextField1()
        setPasswordTextField2()
        setLoginButton()
        setCreateNewUser()
    }
    private func setLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(243)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalToSuperview().inset(90)
        }
    }
    private func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(76)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
    }
    private func setNumberTextField() {
        view.addSubview(stackHLabel)
        stackHLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
        
        stackHLabel.addArrangedSubview(codeTextField)
        stackHLabel.addArrangedSubview(numberTextField)
        
        codeTextField.snp.makeConstraints { make in
            make.width.equalTo(58)
        }
    }
    private func setPasswordTextField1() {
        view.addSubview(passwordTextField1)
        passwordTextField1.snp.makeConstraints { make in
            make.top.equalTo(stackHLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
        
        view.addSubview(criterionLabel)
        criterionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField1.snp.bottom).offset(2)
            make.left.equalTo(33)
        }
    }
    private func setPasswordTextField2() {
        view.addSubview(passwordTextField2)
        passwordTextField2.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField1.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
    }
    private func setLoginButton() {
        view.addSubview(signupButton)
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        
        signupButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(52)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
        }
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
            make.top.equalTo(signupButton.snp.bottom).offset(23)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        stackVLabel.addArrangedSubview(newUserLabel)
        stackVLabel.addArrangedSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(14)
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

extension SignupViewController {
    @objc private func signupButtonTapped() {
        let vc = RoleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
//        if passwordTextField1.text == passwordTextField2.text, let text = passwordTextField1.text {
//            let email = emailTextField.text!
//            let password = text
//    let phoneNumber = numberTextField.text!
//            let parameters = ["email": email, "password": password, "phone": phoneNumber]
//            
//            AF.request(Configuration.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
//                var resultString = ""
//                
//                if let data = response.data{
//                    resultString = String(data: data, encoding: .utf8)!
//                }
//                
//                print(response.response?.statusCode)
//                
//                if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
//                    let json = JSON(response.data!)
//                    
//                    if let token = json["request_number"].string {
//                        Storage.sharedInstance.accessToken = token
//                        UserDefaults.standard.set(token, forKey: "accessToken")
//                        let vc = RoleViewController()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                        self.present(vc, animated: true)
//                    } else {
//                            //                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
//                    }
//                } else {
//                    var ErrorString = "CONNECTION_ERROR"
//                    if let sCode = response.response?.statusCode {
//                        switch sCode {
//                        case 401:
//                            ErrorString += "Unauthorized"
//                        case 403:
//                            ErrorString += "Forbidden"
//                        case 404:
//                            ErrorString += "Not found"
//                        default:
//                            ErrorString += "Қате формат"
//                        }
//                    }
//                    ErrorString += " \(resultString)"
//                }
//            }
//        } else {
//            return
//        }
                
    }
    
    @objc func loginButtonTapped() {
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
