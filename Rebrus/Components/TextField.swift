//
//  TextField.swift
//  Rebrus
//
//

import Foundation
import UIKit
import SnapKit

class TextField: UITextField {
    private var isError: Bool = false
    private var isPassword: Bool = false
    private var isSecure: Bool = true
    private var passwordText: String = ""
    private var originalText: String = ""
    private var hashPassword = ""
    
    private var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.text = "Адрес электронной почты".localized(from: .auth)
        placeholderLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5)
        placeholderLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        return placeholderLabel
    }()
    
    private let showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setupTextFieldPlaceholder()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
        setupTextFieldPlaceholder()
        
        showPasswordButtonTapped()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorder()
    }
}

extension TextField {
    private func setupTextFieldPlaceholder() {
        
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func setupBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        bottomLine.backgroundColor = isError ? UIColor.red.cgColor : ColorManager.black?.cgColor
        layer.addSublayer(bottomLine)
    }
    
    private func setupTextField() {
        self.font = UIFont(name: "Montserrat-Regular", size: 16)
        textColor = isError ? .red : .black
        
        setupBorder()
        
        if isPassword {
            isUserInteractionEnabled = true
            addSubview(showPasswordButton)
            delegate = self
            
            showPasswordButton.addTarget(
                self,
                action: #selector(showPasswordButtonTapped),
                for: .touchUpInside
            )
            
            showPasswordButton.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(22)
                make.right.equalToSuperview()
                make.top.equalTo(20)
            }
        }
    }
    
    @objc private func showPasswordButtonTapped() {
        isSecure.toggle()
        let passwordLength = originalText.count
        let maskedPassword = String(repeating: "*", count: passwordLength)
        text = isSecure ? maskedPassword : originalText
    }
}

extension TextField: UITextFieldDelegate {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if isPassword {
            return bounds.inset(by: UIEdgeInsets(top: 32, left: 0, bottom: 9, right: 20))
        } else {
            return bounds.inset(by: UIEdgeInsets(top: 32, left: 0, bottom: 9, right: 0))
        }
    }
    
    override func editingRect (forBounds bounds: CGRect) -> CGRect {
        if isPassword {
            return bounds.inset(by: UIEdgeInsets(top: 32, left: 0, bottom: 9, right: 20))
        } else {
            return bounds.inset(by: UIEdgeInsets(top: 32, left: 0, bottom: 9, right: 0))
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self {
            let newChar = string.first
            let offsetToUpdate = passwordText.index(passwordText.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText.remove(at: offsetToUpdate)
            } else {
                passwordText.insert(newChar!, at: offsetToUpdate)
            }
            
            originalText = passwordText
            
            if isSecure {
                hashPassword = String(repeating: "*", count: passwordText.count)
            } else {
                hashPassword = passwordText
            }
            
            text = isSecure ? hashPassword : originalText
            
            return false
        }
        
        return true
    }
}

extension TextField {
    func setPlaceholderText (_ text: String) {
        placeholderLabel.text = text
    }
    
    func isEror (_ isError: Bool) {
        self.isError = isError
        setupTextField()
    }
    
    func setTextToTextField (_ text: String) {
        self.text = text
    }
    
    func setPasswordTextField (_ isPassword: Bool) {
        self.isPassword  = isPassword
        setupTextField()
    }
}

