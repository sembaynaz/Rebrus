//
//  SignupViewController.swift
//  Rebrus
//
//  Created by Nazerke Sembay on 19.01.2024.
//

import UIKit

class SignupViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        return imageView
    }()
    
    private let emailTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Адрес электронной почты")
        textfield.placeholder = "Введите email"
        return textfield
    }()
    
    private let codeTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Номер телефона")
        textfield.setTextToTextField("KZ +7")
        textfield.allowsEditingTextAttributes = false
        return textfield
    }()
    
    private let numberTextField: TextField = {
        let textfield = TextField()
        textfield.placeholder = "Введите номер телефона"
        textfield.setPlaceholderText("")
        return textfield
    }()
    
    private let passwordTextField1: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль")
        textfield.placeholder = "Введите пароль"
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let passwordTextField2: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль")
        textfield.placeholder = "Подтвердите пароль"
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let loginButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Продолжить", for: .normal)
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
        label.text = "Уже есть аккаунт?"
        label.textColor = ColorManager.black
        return label
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        button.setTitle("Войти в аккаунт", for: .normal)
        button.setTitleColor(ColorManager.blue, for: .normal)
        return button
    }()
    
    let criterionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.text = "должно содержать 8 символов."
        label.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
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
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(52)
            make.top.equalTo(passwordTextField2.snp.bottom).offset(80)
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
            make.top.equalTo(loginButton.snp.bottom).offset(23)
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

extension SignupViewController {
    @objc func signupButtonTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        let vc = RoleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
