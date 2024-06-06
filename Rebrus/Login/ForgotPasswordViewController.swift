//
//  ForgotPasswordViewController.swift
//  Rebrus
//
//

import UIKit
import Alamofire
import SwiftyJSON

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
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
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
            guard let email = emailTextField.text, !email.isEmpty else {
                print("Email is empty")
                return
            }
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
            ]
            
            print(Storage.sharedInstance.accessToken)
            
            let parameters = ["email": email]
            
            AF.request(Configuration.FORGOT_PASSWORD, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
                .responseData { response in
                    var resultString = ""
                    
                    if let data = response.data {
                        resultString = String(data: data, encoding: .utf8) ?? "No response data"
                    }
                    
                    print(response.response?.statusCode ?? "No status code")
                    print(resultString)
                    
                    let json = JSON(response.data ?? Data())
                    print(json)
                    
                    if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                        let json = JSON(response.data!)
                        print(json)
                        
                        if let requestNumber = json["request_number"].string {
                            let vc = OTPViewController(userEmail: email, requestNumber: requestNumber)
                            vc.buttonTitle = "Изменить пароль".localized(from: .auth)
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            print("success")
                        } else {
                            print("request_number не найден в JSON ответе")
                        }
                    } else {
                        print("Request failed with status: \(response.response?.statusCode ?? 0)")
                        print("Response data: \(resultString)")
                    }
                }
        }
}
