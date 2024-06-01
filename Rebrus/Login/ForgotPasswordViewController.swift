//
//  ForgotPasswordViewController.swift
//  Rebrus
//
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.text = "Забыли пароль".localized(from: .auth)
        label.textColor = ColorManager.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Не беспокойтесь! Введите свой адрес электронной почты, и мы вышлем вам код для сброса пароля.".localized(from: .auth)
        label.numberOfLines = 0
        label.textColor = ColorManager.black
        return label
    }()
    private let emailTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Адрес электронной почты".localized(from: .auth))
        textfield.placeholder = "Введите email".localized(from: .auth)
        return textfield
    }()
    private let codeButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Войти в систему".localized(from: .auth), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Забыли пароль".localized(from: .auth)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension ForgotPasswordViewController {
    private func setupConstraints() {
        setTitleLabel()
        setMessageLabel()
        setEmailTextField()
        setSendCodeButton()
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalTo(view.snp.top).offset(100)
        }
    }
    
    private func setMessageLabel() {
        view.addSubview(messageLabel)
                
        messageLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
        }
    }
    
    private func setEmailTextField() {
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(31)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(60)
        }
    }
    
    private func setSendCodeButton() {
        view.addSubview(codeButton)
        codeButton.addTarget(self, action: #selector(codeButtonTapped), for: .touchUpInside)
        codeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-150)
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(52)
        }
    }
            
}

extension ForgotPasswordViewController {
    @objc func codeButtonTapped() {
        let vc = OTPViewController(userEmail: emailTextField.text!)
        vc.buttonTitle = "Изменить пароль".localized(from: .auth)
        navigationController?.pushViewController(vc, animated: true)
    }
}
