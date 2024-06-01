//
//  OTPViewController.swift
//  Rebrus
//
//

import UIKit
import Alamofire
import SwiftyJSON

class OTPViewController: UIViewController {
    private var userEmail: String
    private var requestNumber: String
    private var createdDate = ""
    private var expirationDate = ""

    
    var buttonTitle = "Создать аккаунт".localized(from: .auth)
    private var code: String = ""
    private var time = 240
    private var timer = Timer()
    
    private let titleOTPLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.text = "Пожалуйста, введите ".localized(from: .onboard)
        label.textColor = ColorManager.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let titleOTPLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.text = "Проверка OTP".localized(from: .onboard)
        label.textColor = ColorManager.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let messageSendedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Код был отправлен в почту "
        label.numberOfLines = 0
        label.textColor = ColorManager.black
        return label
    }()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Срок действия этого кода истекает в ".localized(from: .onboard)
        label.textColor = ColorManager.black
        return label
    }()
    private let resendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Отправить заново?".localized(from: .onboard)
        label.textColor = UIColor.darkGray
        return label
    }()
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    private let createAccountButton: Button = {
        let button = Button()
        button.setTitle("Создать аккаунт".localized(from: .onboard), for: .normal)
        return button
    }()
    private let repeatButton: UIButton = {
        var button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitle("Отправить".localized(from: .onboard), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitleColor(ColorManager.blue, for: .normal)
        return button
    }()
    private let repeatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "repeat")
        return imageView
    }()
    
    init(userEmail: String, requestNumber: String) {
        self.userEmail = userEmail
        self.requestNumber = requestNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var otpView = knOTPView(digitCount: 4, validate: self.validateOtp)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Проверка ОТП".localized(from: .onboard)
        setupConstraints()
        sendCode()
    }
    
    private func sendCode() {
        if let stringValue = UserDefaults.standard.string(forKey: "accessToken") {
            requestNumber = stringValue
        }
        
        let date = Date()
        let date1 = date.addingTimeInterval(4 * 60)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        // Format the created date
        createdDate = dateFormatter.string(from: date)
        expirationDate = dateFormatter.string(from: date1)
        
        
        let parameters = ["request_number": requestNumber, "code": 1234, "expiration_date": expirationDate, "created_date": createdDate] as [String : Any]
        
        AF.request(Configuration.RESEND_CODE, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { [weak self] response in
            guard let self = self else { return }
            var resultString = ""
            
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
            }
            
            print(response.response?.statusCode)
            
            print(response.data)
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                let json = JSON(response.data!)
                self.setTimer()
                print(json)
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
}

extension OTPViewController {
    private func setupConstraints() {
        setTitleOTPLabel()
        setMessageLabel()
        setTimerLabel()
        setOTP()
        setStackView()
        setVerifyButton()
    }
    
    private func setTitleOTPLabel() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(titleOTPLabel1)
        stack.addArrangedSubview(titleOTPLabel2)
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(33)
            make.top.equalTo(view.snp.top).offset(100)
        }
    }
    
    private func setMessageLabel() {
        view.addSubview(messageSendedLabel)
        
        messageSendedLabel.text = "code.send".localized(withAdditionalString: hideEmail(email: userEmail))
        
        
        messageSendedLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalTo(titleOTPLabel2.snp.bottom).offset(10)
        }
    }
    
    private func setTimerLabel() {
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(33)
            make.top.equalTo(messageSendedLabel.snp.bottom).offset(4)
        }
    }
    
    private func setOTP() {
        view.addSubviews(views: otpView)
        
        otpView.horizontal(toView: view, space: 11)
        otpView.top(toView: timerLabel, space: 35)
    }
    
    private func setStackView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(repeatImageView)
        stackView.addArrangedSubview(repeatButton)
        
        repeatImageView.snp.makeConstraints { make in
            make.width.equalTo(14.5)
            make.height.equalTo(14)
        }
        
        stackView.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-33)
            make.top.equalTo(otpView.snp.bottom).offset(35)
        }
        
        setResandLabel()
        
        repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
    }
    
    private func setResandLabel() {
        view.addSubview(resendLabel)
        resendLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(33)
            make.top.equalTo(otpView.snp.bottom).offset(35)
        }
    }
    
    private func setVerifyButton() {
        view.addSubview(createAccountButton)
        createAccountButton.setTitle(buttonTitle, for: .normal)
        createAccountButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        
        createAccountButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
            make.height.equalTo(52)
        }
    }
}

extension OTPViewController {
    @objc private func verifyButtonTapped() {
        if buttonTitle == "Создать аккаунт".localized(from: .onboard) {
            let parameters = ["request_number": requestNumber, "code": 1234, "expiration_date": expirationDate, "created_date": createdDate] as [String : Any]
            
            
            AF.request(Configuration.CHECK_CODE, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
                var resultString = ""
                
                if let data = response.data{
                    resultString = String(data: data, encoding: .utf8)!
                }
                
                print(response.response?.statusCode)
                
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                    let json = JSON(response.data!)
                    if let token = json["access_token"].string {
                        Storage.sharedInstance.accessToken = token
                        UserDefaults.standard.set(token, forKey: "accessToken")
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
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
            
        } else {
            let vc = ChangePasswordViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension OTPViewController {
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
    }
    
    @objc private func timerCount() {
        time -= 1
        if time >= 0 {
            updateTimerLabel(redText: String(format: "00:%0.2d", time))
        }
        
        if time == 0 {
            timer.invalidate()
            repeatButton.isHidden = false
            repeatImageView.isHidden = false
        }
    }
    
    @objc private func repeatButtonTapped() {
        time = 10
        setTimer()
        repeatImageView.isHidden = true
        repeatButton.isHidden = true
    }
}

extension OTPViewController {
    private func hideEmail(email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else {
            return email
        }
        
        let prefix = email.prefix(2)
        let suffix = email.suffix(from: atIndex)
        
        let hiddenPart = String(repeating: "*", count: email.count - 2 - suffix.count)
        
        return prefix + hiddenPart + suffix
    }
    
    private func updateTimerLabel(redText: String) {
        let blackText = "Срок действия этого кода истекает в ".localized(from: .onboard)
        let blackAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ColorManager.black!, .font: UIFont(name: "Montserrat-Regular", size: 14) as Any]
        let blackAttributedString = NSAttributedString(string: blackText, attributes: blackAttributes)
        
        let redAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ColorManager.red!, .font: UIFont(name: "Montserrat-Medium", size: 14) as Any]
        let redAttributedString = NSAttributedString(string: redText, attributes: redAttributes)
        
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(blackAttributedString)
        fullAttributedString.append(redAttributedString)
        
        timerLabel.attributedText = fullAttributedString
    }
}

extension OTPViewController {
    private func validateOtp(_ code: String) {
        print("Your code is \(code)")
    }
}
