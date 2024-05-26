//
//  DeleteHalfScreenViewController.swift
//  Rebrus
//
//

import UIKit

class DeleteHalfScreenViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы уверены, что хотите удалить свой аккаунт?".localized(from: .main)
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Все ваши данные, включая сохраненные настройки и историю активности, будут безвозвратно удалены. ".localized(from: .main)
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.textColor = ColorManager.subtitleTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorManager.red
        button.layer.cornerRadius = 26
        button.setTitle("Удалить аккаунт".localized(from: .main), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить".localized(from: .main), for: .normal)
        button.setTitleColor(ColorManager.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        cancelButton.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setDefaultFrame()
        self.view.layer.cornerRadius = 12
        self.view.layer.masksToBounds = true
    }
    
    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 13
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        stack.addArrangedSubview(deleteButton)
        stack.addArrangedSubview(cancelButton)
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(31)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        deleteButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        let handle = UIView()
        handle.backgroundColor = ColorManager.borderColor?.withAlphaComponent(0.5)
        handle.layer.cornerRadius = 2
        
        view.addSubview(handle)
        handle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(3)
            make.width.equalTo(48)
        }
    }
}
extension DeleteHalfScreenViewController {
    private func setDefaultFrame() {
        self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 5 * 2.8, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 2.7)
    }
    
    @objc private func cancelBtnTapped() {
        dismiss(animated: true)
    }
    
    @objc private func deleteBtnTapped() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let launchController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        launchController?.modalPresentationStyle = .fullScreen
        self.present(launchController!, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            launchController!.dismiss(animated: false) {
                let rootViewController = UINavigationController(rootViewController: OnboardingViewController())
                window.rootViewController?.dismiss(animated: false, completion: nil)
                window.rootViewController = nil
                window.rootViewController = rootViewController
                window.makeKeyAndVisible()
            }
        }
    }
}
