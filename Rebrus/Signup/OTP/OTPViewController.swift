//
//  OTPViewController.swift
//  Rebrus
//
//  Created by Nazerke Sembay on 19.01.2024.
//

import UIKit

class OTPViewController: UIViewController {
    var buttonTitle = "Создать аккаунт"
    private var code: String = ""
    private var time = 10
    private var timer = Timer()
    private var userEmail: String = "ulankdt@gmail.com"
    
    private let titleOTPLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.text = "Пожалуйста, введите\nПроверка OTP"
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
        label.text = "Срок действия этого кода истекает в "
        label.textColor = ColorManager.black
        return label
    }()
    private let resendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "Отправить заново?"
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
        button.setTitle("Создать аккаунт", for: .normal)
        return button
    }()
    private let repeatButton: UIButton = {
        var button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.setTitleColor(ColorManager.blue, for: .normal)
        return button
    }()
    private let repeatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "repeat")
        return imageView
    }()
    
    lazy var otpView = knOTPView(digitCount: 4, validate: self.validateOtp)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setTimer()
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
        view.addSubview(titleOTPLabel)
        titleOTPLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(33)
            make.top.equalTo(view.snp.top).offset(100)
        }
    }
    
    private func setMessageLabel() {
        view.addSubview(messageSendedLabel)
        
        messageSendedLabel.text! += hideEmail(email: userEmail)
        
        messageSendedLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalTo(titleOTPLabel.snp.bottom).offset(10)
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
        if buttonTitle == "Создать аккаунт" {
            let vc = UINavigationController(rootViewController: LoginViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
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
        let blackText = "Срок действия этого кода истекает в "
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
