//
//  PatientPreviewTableViewCell.swift
//  Rebrus
//
//

import UIKit

class PatientPreviewTableViewCell: UITableViewCell {

    static let identifier = "PatientPreviewTableViewCell"

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.textColor = ColorManager.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    private let iinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
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
    
    func setContent(patient: Patient) {
        userNameLabel.text = [patient.lastName, patient.firstName, patient.middleName].compactMap { $0 }.joined(separator: " ")
        iinLabel.text = "ИИН".localized(from: .main) + ": " + patient.iin
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
