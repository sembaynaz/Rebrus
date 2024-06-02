//
//  ChangePasswordViewController.swift
//  Rebrus
//
//

import UIKit
import SwiftyJSON
import Alamofire

class ChangePasswordViewController: UIViewController {
    var isChangePassword = false
    var token: String
    
    private let passwordTextField1: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль".localized(from: .auth))
        textfield.placeholder = "Введите новый пароль".localized(from: .auth)
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let passwordTextField2: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль".localized(from: .auth))
        textfield.placeholder = "Введите пароль повторно".localized(from: .onboard)
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    private let passwordTextField3: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Подтвердите пароль".localized(from: .onboard))
        textfield.placeholder = "Введите пароль повторно".localized(from: .onboard)
        textfield.setPasswordTextField(true)
        return textfield
    }()
    
    let criterionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.text = "должно содержать 8 символов.".localized(from: .auth)
        label.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        return label
    }()
    private let changeButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Сбросить пароль".localized(from: .auth), for: .normal)
        return button
    }()
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Сбросить пароль".localized(from: .auth)
        setupConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ChangePasswordViewController {
    private func setupConstraints() {
        setPasswordTextField1()
        setPasswordTextField2()
        setLoginButton()
        
        if isChangePassword {
            passwordTextField1.setPlaceholderText("Текущий пароль".localized(from: .main))
            passwordTextField1.placeholder = "Введите текущий пароль".localized(from: .main)
            passwordTextField2.setPlaceholderText("Пароль".localized(from: .main))
            passwordTextField2.placeholder = "Введите новый пароль".localized(from: .main)
            
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
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        print(token, "token")
        
            //        var password = ""
        
            //        if passwordTextField1.text! == passwordTextField2.text! {
            //            password = passwordTextField1.text!
            //        } else {
            //            print("not match")
            //            return
            //        }
        
        
        let parameters = ["password": passwordTextField1.text!]
        
        AF.request(Configuration.RESET_PASSWORD, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                var resultString = ""
                
                if let data = response.data {
                    resultString = String(data: data, encoding: .utf8)!
                }

                
                print(response.response?.statusCode)
                
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                    if let navigationController = self.navigationController {
                        navigationController.popToRootViewController(animated: true)
                    }
                    print("success")
                }
            }

        
    }

}
