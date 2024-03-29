//
//  ChangePasswordViewController.swift
//  Rebrus
//
//  Created by Nazerke Sembay on 19.01.2024.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    var isChangePassword = false
    
    private let passwordTextField1: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль")
        textfield.placeholder = "Введите ноый пароль"
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let passwordTextField2: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль")
        textfield.placeholder = "Введите пароль повторно"
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let passwordTextField3: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Подтвердите пароль")
        textfield.placeholder = "Введите пароль повторно"
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    let criterionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.text = "должно содержать 8 символов."
        label.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        return label
    }()
    private let changeButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Сбросить папроль", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Сбросить пароль"
        setupConstraints()
    }

}

extension ChangePasswordViewController {
    private func setupConstraints() {
        setPasswordTextField1()
        setPasswordTextField2()
        setLoginButton()
        
        if isChangePassword {
            passwordTextField1.setPlaceholderText("Текущий пароль")
            passwordTextField1.placeholder = "Введите текущий пароль"
            passwordTextField2.setPlaceholderText("Пароль")
            passwordTextField2.placeholder = "Введите новый пароль"
            
            view.addSubview(passwordTextField3)
            passwordTextField3.snp.makeConstraints { make in
                make.top.equalTo(passwordTextField2.snp.bottom).offset(32)
                make.horizontalEdges.equalToSuperview().inset(33)
                make.height.equalTo(60)
            }
        }
    }
    
    private func setPasswordTextField1() {
        view.addSubview(passwordTextField1)
        passwordTextField1.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(150)
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
        view.addSubview(changeButton)
        
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        
        changeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(52)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
        }
    }
}

extension ChangePasswordViewController {
    @objc func changeButtonTapped() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

}
