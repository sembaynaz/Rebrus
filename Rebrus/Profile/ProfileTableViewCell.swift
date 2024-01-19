//
//  ProfileTableViewCell.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 16/01/2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let identifier = "ProfileTableViewCell"

    private let iconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ColorManager.lightGrey
        view.layer.cornerRadius = 22
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = ColorManager.black
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 11)
        label.textColor = ColorManager.darkGrey
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupUI()
    }
    
    func setContent(icon: String, title: String, subtitle: String) {
        iconView.image = UIImage(named: icon)
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension ProfileTableViewCell {
    private func setupUI() {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 7
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(16)
            make.size.equalTo(44)
        }
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevron.tintColor = ColorManager.darkGrey
        chevron.contentMode = .scaleAspectFit
        
        contentView.addSubview(chevron)
        chevron.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
            make.width.equalTo(9)
        }
        
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(15)
            make.trailing.equalTo(chevron.snp.leading)
            make.centerY.equalToSuperview()
        }
        
        let lineView = UIView()
        lineView.backgroundColor = ColorManager.grey
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
