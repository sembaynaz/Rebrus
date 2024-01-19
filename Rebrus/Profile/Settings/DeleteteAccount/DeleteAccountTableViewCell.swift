//
//  DeleteAccountTableViewCell.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 19/01/2024.
//

import UIKit

class DeleteAccountTableViewCell: UITableViewCell {

    static let identifier = "DeleteAccountTableViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 15)
        label.textColor = ColorManager.blue
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.grey
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = ColorManager.lightGrey
        setupUI()
    }
    
    func setContent(with text: String, isLast: Bool) {
        label.text = text
        lineView.isHidden = isLast
    }
    
    func setSelected(isSelected: Bool) {
        backgroundColor = isSelected ? ColorManager.blue : ColorManager.lightGrey
        label.textColor = isSelected ? .white : ColorManager.blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension DeleteAccountTableViewCell {
    private func setupUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}
