//
//  LanguageViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 18/01/2024.
//

import UIKit

enum Language: Int {
    case ru
    case kk
    case en
    
    func getLocalizationLanguage() -> String {
        switch self {
        case .ru:
            return "ru"
        case .kk:
            return "kk"
        case .en:
            return "en"
        }
    }
    
    func getLanguageFullName() -> String {
        switch self {
        case .ru:
            return "Русский язык"
        case .kk:
            return "Қазақ тілі"
        case .en:
            return "English"
        }
    }
}

class LanguageViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Выберите предпочитаемый язык."
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.textColor = ColorManager.black
        label.numberOfLines = 0
        return label
    }()
    
    private var buttons: [RoundOptionButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Язык"
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc private func optionTapped(_ sender: RoundOptionButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {
            return
        }
        
        for (index, button) in buttons.enumerated() {
            button.setActive(index == buttonIndex)
        }
    }
}

//MARK: - UI setups
extension LanguageViewController {
    private func setupUI() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(makeOptionsBlock(with: "Предлагаемые", for: [.ru, .kk]))
        
        let lineView = UIView()
        lineView.backgroundColor = ColorManager.borderColor
        stack.addArrangedSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        stack.addArrangedSubview(makeOptionsBlock(with: "Остальные", for: [.en]))
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        buttons[0].setActive(true)
    }
    
    private func makeOptionsBlock(with title: String, for options: [Language]) -> UIStackView {
        let blockStack = UIStackView()
        blockStack.axis = .vertical
        blockStack.spacing = 10
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.textColor = ColorManager.blue
        label.text = title
        
        let optionsStack = UIStackView()
        optionsStack.axis = .vertical
        optionsStack.spacing = 10
        
        for option in options {
            let optionView = makeOption(with: option.getLanguageFullName())
            optionsStack.addArrangedSubview(optionView)
        }
        
        blockStack.addArrangedSubview(label)
        blockStack.addArrangedSubview(optionsStack)
        
        return blockStack
    }

    private func makeOption(with optionName: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = ColorManager.black
        label.text = optionName
        
        let button = RoundOptionButton()
        button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
        buttons.append(button)
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(button)
        
        return stack
    }
}
