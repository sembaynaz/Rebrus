//
//  UserDataTableViewCell.swift
//  Rebrus
//
//

import UIKit

class UserDataTableViewCell: UITableViewCell {
    
    static let identifier = "UserDataTableViewCell"
    weak var delegate: SendValueDelegate?
    private let textField = TextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        textField.delegate = self
        setupUI()
    }
    
    func setContent(text: String?, placeHolder: String?, title: String) {
        textField.setPlaceholderText(title.localized(from: .main))
        textField.placeholder = placeHolder?.localized(from: .main)
        textField.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension UserDataTableViewCell {
    private func setupUI() {
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview()
        }
    }
}
//MARK: - UITextFieldDelegate
extension UserDataTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
            
            if let stringRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                
                delegate?.valueChanged(in: self, value: updatedText)
            }
            
            return true
    
    }
}
