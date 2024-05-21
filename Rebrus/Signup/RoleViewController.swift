    //
    //  RoleViewController.swift
    //  Rebrus
    //
    //  Created by Nazerke Sembay on 19.01.2024.
    //

import UIKit

class RoleViewController: UIViewController {
    
    private var specialistButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderColor = ColorManager.black?.cgColor
        button.layer.borderWidth = 1
        button.setTwoTexts(firstText: "Я специалист".localized(from: .onboard), secondText: "Ваша ответственность - регистрация пациентов, сбор точных данных и проведение медицинских тестов.".localized(from: .onboard))
        button.setTitleColor(ColorManager.black, for: .normal)
        return button
    }()
    
    private var drButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderColor = ColorManager.black?.cgColor
        button.layer.borderWidth = 1
        button.setTwoTexts(firstText: "Я доктор".localized(from: .onboard), secondText: "Ваша роль - заботиться о здоровье пациентов, анализировать истории и назначать лечение.".localized(from: .onboard))
        button.setTitleColor(ColorManager.black, for: .normal)
        return button
    }()
    
    private let nextButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Продолжить".localized(from: .onboard), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор роли".localized(from: .onboard)
        view.backgroundColor = .white
        setupUI()
    }
}

extension RoleViewController {
    private func setupUI() {
        setSpecialistButton()
        setDrButton()
        setNextButton()
    }
    
    private func setSpecialistButton() {
        view.addSubview(specialistButton)
        
        specialistButton.addTarget(self, action: #selector(specialistButtonTapped), for: .touchUpInside)
        
        specialistButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalToSuperview().inset(235)
            make.height.equalTo(140)
        }
    }
    
    private func setDrButton() {
        view.addSubview(drButton)
        
        drButton.addTarget(self, action: #selector(drButtonTapped), for: .touchUpInside)
        
        drButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.top.equalTo(specialistButton.snp.bottom).offset(34)
            make.height.equalTo(140)
        }
    }
    
    private func setNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
            make.height.equalTo(52)
        }
    }
}

extension RoleViewController {
    @objc private func nextButtonTapped() {
        let vc = OTPViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func specialistButtonTapped() {
        deselect(button: drButton)
        select(button: specialistButton)
    }
    
    @objc private func drButtonTapped() {
        deselect(button: specialistButton)
        select(button: drButton)
    }
}

extension RoleViewController {
    private func deselect(button: UIButton) {
        button.layer.borderColor = ColorManager.black?.cgColor
        button.setTitleColor(ColorManager.black, for: .normal)
    }
    
    private func select(button: UIButton) {
        button.layer.borderColor = ColorManager.blue?.cgColor
        button.setTitleColor(ColorManager.blue, for: .normal)
    }
}

