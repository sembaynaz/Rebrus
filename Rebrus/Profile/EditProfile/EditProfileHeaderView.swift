//
//  EditProfileHeaderView.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 25/03/2024.
//

import UIKit

class EditProfileHeaderView: UIView {
    
    weak var delegate: SomethingTappedDelegate?
    
    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 60
        
        return view
    }()
    
    private let titleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(ColorManager.black, for: .normal)
        button.setTitle("Выбрать фотографию", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        return button
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        setupUI()
        titleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        
        addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.trailing.leading.bottom.equalToSuperview().inset(16)
        }
    }
}
