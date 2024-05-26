//
//  LanguageViewController.swift
//  Rebrus
//
//

import UIKit


class LanguageViewController: UIViewController {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.textColor = ColorManager.black
        label.numberOfLines = 0
        return label
    }()
    
    private var labels: [UILabel] = []
    
    private var buttons: [RoundOptionButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setStrings()
        setActiveLanguage()
    }
    
    @objc private func optionTapped(_ sender: RoundOptionButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {
            return
        }
        
        for (index, button) in buttons.enumerated() {
            button.setActive(index == buttonIndex)
        }
        
        MTUserDefaults.shared.language = Language(rawValue: buttonIndex) ?? .ru
        NotificationCenter.default.post(name: Notification.Name("localize"), object: nil)
        setStrings()
    }
    
    private func setStrings() {
        title = "Язык".localized(from: .main)
        mainLabel.text = "Выберите предпочитаемый язык.".localized(from: .main)
        labels[0].text = "Предлагаемые".localized(from: .main)
        labels[1].text = "Остальные".localized(from: .main)
    }
}

//MARK: - UI setups
extension LanguageViewController {
    private func setupUI() {
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(makeOptionsBlock(for: [.ru, .kz]))
        
        let lineView = UIView()
        lineView.backgroundColor = ColorManager.borderColor
        stack.addArrangedSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        stack.addArrangedSubview(makeOptionsBlock(for: [.en]))
        
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        
    }
    
    private func setActiveLanguage() {
        buttons[MTUserDefaults.shared.language.rawValue].setActive(true)
        
    }
    
    private func makeOptionsBlock(for options: [Language]) -> UIStackView {
        let blockStack = UIStackView()
        blockStack.axis = .vertical
        blockStack.spacing = 10
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.textColor = ColorManager.blue
        labels.append(label)
        
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
