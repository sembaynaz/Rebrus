    //
    //  knOTPView.swift
    //  Rebrus
    //
    //  Created by Nazerke Sembay on 19.01.2024.
    //

import Foundation
import UIKit

class knOTPView: knView {
    private let color_69_125_245 = ColorManager.black
    private let color_102 = UIColor.lightGray
    private let color_253_102_127 = UIColor.lightGray
    lazy var hiddenTextField = self.addHiddenTextField()
    private var labels = [UILabel]()
    private var digitCount = 0
    private var validate: ((String) -> Void)?
    private var hashText: String = ""
    private var originalText: String = ""
    private var isInvalid = false {
        didSet {
            if isInvalid { setCodeError(); return }
            hiddenTextField.text = ""
            for i in 0 ..< digitCount {
                setCode(at: i, active: false)
                labels[i].textColor = color_69_125_245
                labels[i].text = ""
            }
            setCode(at: 0, active: true)
        }}
    
    convenience init(digitCount: Int, validate: @escaping ((String) -> Void)) {
        self.init(frame: CGRect.zero)
        self.digitCount = digitCount
        self.validate = validate
        setupView()
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        hiddenTextField.becomeFirstResponder()
        return true
    }
    
    private func addHiddenTextField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.isHidden = true
        tf.delegate = self
        
        addSubviews(views: tf)
        tf.fill(toView: self)
        
        return tf
    }
    
    override func setupView() {
        guard digitCount > 0 else { return }
        var constraints = "H:|-22-"
        for i in 0 ..< digitCount {
            let label = makeLabel()
            if i > 0 {
                label.width(toView: labels[0])
            }
            constraints += "[v\(i)]-22-"
        }
        constraints += "|"
        addConstraints(withFormat: constraints, arrayOf: labels)
        height(64)
        
        setCode(at: 0, active: true)
        hiddenTextField.becomeFirstResponder()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(becomeFirstResponder)))
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 45)
        label.textColor = color_69_125_245
        label.textAlignment = .center
        label.createRoundCorner(16)
        label.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.1)
        addSubview(label)
        label.vertical(toView: self)
        labels.append(label)
        return label
    }
}

extension knOTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxCharacterLimit = 4
        if let text = textField.text, let range = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            
            if updatedText.count > maxCharacterLimit {
                return false
            }
        }
        
        var newText = string
        
        if isInvalid {
            isInvalid = false
        } else {
            newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            print(newText)
            
            if string.isEmpty {
                    // Handle deletion
                originalText = String(originalText.dropLast())
            } else if let newCharacter = newText.last {
                    // Handle addition
                originalText.append(newCharacter)
            }
        }
        
        let codeLength = newText.count
        guard codeLength <= digitCount else { return false }
        
        if textField.text == nil {
            hashText = ""
            originalText = ""
            newText = ""
        }
        
        hashText = String(repeating: "•", count: newText.count)
        textField.text = hashText
        
        func setTextToActiveBox() {
            for i in 0 ..< codeLength {
                let char = String(newText[newText.index(newText.startIndex, offsetBy: i)])
                labels[i].text = char
                setCode(at: i, active: true)
            }
        }
        
        func setTextToInactiveBox() {
            for i in codeLength ..< digitCount {
                labels[i].text = ""
                setCode(at: i, active: false)
            }
            
            if codeLength <= digitCount - 1 {
                setCode(at: codeLength, active: true)
            }
        }
        
        setTextToActiveBox()
        setTextToInactiveBox()
        
        if codeLength == digitCount {
            validateCode(code: originalText)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.updateCodeWithStars(codeLength: codeLength)
        }
        
        return false
    }

    private func updateCodeWithStars(codeLength: Int) {
        for i in 0 ..< codeLength {
            labels[i].text = "•"
            setCode(at: i, active: true)
        }
    }
    
    func setCode(at index: Int, active: Bool) {
//        labels[index].createBorder(active ? 1 : 0.5,
//                                   color: active ? color_69_125_245! : color_102)
    }
    
    func setCodeError() {
        for i in 0 ..< digitCount {
            labels[i].createBorder(0.5, color: color_253_102_127)
            labels[i].textColor = color_253_102_127
        }
    }
    
    func validateCode(code: String) {
        validate?(code)
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(endIndex, offsetBy: -(count - to) + 1)
        let range = start ..< end
        return String(self[range])
    }
}

extension UIView {
    func createBorder(_ width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    @objc func createRoundCorner(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

class knView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        
    }
}

    //⋅ · ● ● •
