    //
    //  RoleViewController.swift
    //  Rebrus
    //
    //  Created by Nazerke Sembay on 19.01.2024.
    //

import UIKit
import Alamofire
import SwiftyJSON

enum SpecialistRole: String {
    case specialist = "SPECIALIST"
    case doctor = "DOCTOR"
}

class RoleViewController: UIViewController {
    private var email: String
    private var password: String
    private var phoneNumber: String
    private var role: SpecialistRole = .specialist
    private var specialistButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderColor = ColorManager.black?.cgColor
        button.layer.borderWidth = 1
        button.setTwoTexts(firstText: "Я специалист".localized(from: .onboard), secondText: "Ваша ответственность - регистрация пациентов, сбор точных данных и проведение медицинских тестов.".localized(from: .onboard))
        button.setTitleColor(ColorManager.black, for: .normal)
        return button
    }()
    
    private var drButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderColor = ColorManager.black?.cgColor
        button.layer.borderWidth = 1
        button.setTwoTexts(firstText: "Я доктор".localized(from: .onboard), secondText: "Ваша роль - заботиться о здоровье пациентов, анализировать истории и назначать лечение.".localized(from: .onboard))
        button.setTitleColor(ColorManager.black, for: .normal)
        return button
    }()
    
    private let nextButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Продолжить".localized(from: .onboard), for: .normal)
        return button
    }()
    
    init(email: String, password: String, phoneNumber: String) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор роли".localized(from: .onboard)
        view.backgroundColor = .white
        setupUI()
    }
}

extension RoleViewController {
    private func setupUI() {
        setSpecialistButton()
        setDrButton()
        setNextButton()
    }
    
    private func setSpecialistButton() {
        view.addSubview(specialistButton)
        
        specialistButton.addTarget(self, action: #selector(specialistButtonTapped), for: .touchUpInside)
        
        specialistButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalToSuperview().inset(235)
            make.height.equalTo(140)
        }
    }
    
    private func setDrButton() {
        view.addSubview(drButton)
        
        drButton.addTarget(self, action: #selector(drButtonTapped), for: .touchUpInside)
        
        drButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalTo(specialistButton.snp.bottom).offset(34)
            make.height.equalTo(140)
        }
    }
    
    private func setNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
            make.height.equalTo(52)
        }
    }
}

extension RoleViewController {
    @objc private func nextButtonTapped() {
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "phone": phoneNumber,
            "role": role.rawValue,
            "profile": [
                    "firstName": "string",
                    "lastName": "string",
                    "middleName": "string",
                    "birthDate": "2024-06-01",
                    "gender": "M",
                    "region": "string"
                ]
        ]
        
        AF.request(Configuration.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            var resultString = ""
            
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
            }
            
            print(response.response?.statusCode)
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                let json = JSON(response.data!)
                
                if let token = json["request_number"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    let vc = OTPViewController(userEmail: self.email)
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                        //                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
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
    
    @objc private func specialistButtonTapped() {
        deselect(button: drButton)
        select(button: specialistButton)
        role = .specialist
    }
    
    @objc private func drButtonTapped() {
        deselect(button: specialistButton)
        select(button: drButton)
        role = .doctor
    }
}

extension RoleViewController {
    private func deselect(button: UIButton) {
        button.layer.borderColor = ColorManager.black?.cgColor
        button.setTitleColor(ColorManager.black, for: .normal)
    }
    
    private func select(button: UIButton) {
        button.layer.borderColor = ColorManager.blue?.cgColor
        button.setTitleColor(ColorManager.blue, for: .normal)
    }
}

