//
//  PatientPreviewTableViewCell.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 08/05/2024.
//

import UIKit

class PatientPreviewTableViewCell: UITableViewCell {

    static let identifier = "PatientPreviewTableViewCell"

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.text = "Кожабеков Улан Даулетулы"
        label.textColor = ColorManager.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    private let iinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.text = "ИИН: 021014501033"
        label.textColor = ColorManager.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupUI()
    }
    
    func setContent(username: String, iin: String) {
        userNameLabel.text = username
        iinLabel.text = iin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension PatientPreviewTableViewCell {
    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.addArrangedSubview(userNameLabel)
        stack.addArrangedSubview(iinLabel)
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(23)
            make.leading.equalToSuperview().inset(14)
        }
    }
}
