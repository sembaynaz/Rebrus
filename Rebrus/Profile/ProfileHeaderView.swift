//
//  ProfileHeaderView.swift
//  Rebrus
//
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.image = UIImage(named: "avatar")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 31
    
        return view
    }()
    
    private let userFullName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Имя Фамилия".localized(from: .main)
        label.font = UIFont(name: "Montserrat-Medium", size: 20)
        return label
    }()
    
    private let userEmail: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "example@example.com"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        setupUI()
    }
    
    func setContent(user: User) {
        if user.firstName == nil, user.lastName == nil {
            userFullName.text = "Имя Фамилия".localized(from: .main)
        } else {
            userFullName.text = user.firstName! + " " + user.lastName!
        }
        
        userEmail.text = user.email
    }
    
    func setUserPhoto(image: UIImage) {
        userImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension ProfileHeaderView {

    private func setupUI() {
        let block = UIView()
        block.backgroundColor = ColorManager.blue
        block.layer.cornerRadius = 15
        
        addSubview(block)
        block.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 7
        
        vStack.addArrangedSubview(userFullName)
        vStack.addArrangedSubview(userEmail)
        
        
        block.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(62)
        }
        
        block.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
