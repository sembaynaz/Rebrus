//
//  EditProfileHeaderView.swift
//  Rebrus
//
//

import UIKit

class EditProfileHeaderView: UIView {
    
    weak var delegate: SomethingTappedDelegate?
    
    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatarReversed")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 60
        
        return view
    }()
    
    private let changePhoto = UIButton()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ColorManager.black
        label.text = "Выбрать фотографию".localized(from: .main)
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        setupUI()
        changePhoto.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setContent(image: UIImage) {
        userImageView.image = image
    }
    
    @objc private func buttonTapped() {
        delegate?.somethingTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension EditProfileHeaderView {

    private func setupUI() {
        addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.trailing.leading.bottom.equalToSuperview().inset(16)
        }
        
        addSubview(changePhoto)
        changePhoto.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.leading.trailing.bottom.equalTo(titleLabel)
        }
    }
}
