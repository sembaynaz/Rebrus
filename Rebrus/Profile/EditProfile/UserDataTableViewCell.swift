//
//  UserDataTableViewCell.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 25/03/2024.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {

    static let identifier = "UserDataTableViewCell"

    private let textField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Фамилия")
        textfield.placeholder = "Кожабеков"
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupUI()
    }
    
    func setContent(text: String?, placeHolder: String?, title: String) {
        textField.setPlaceholderText(title)
        textField.placeholder = placeHolder
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
