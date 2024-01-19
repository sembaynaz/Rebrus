//
//  StartViewController.swift
//  Rebrus
//
//  Created by Nazerke Sembay on 17.01.2024.
//

import UIKit

class StartViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoWhite")
        return imageView
    }()
    
    private let loginButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Войти в систему", for: .normal)
        return button
    }()
    
    private let signupButton: Button = {
        let button = Button()
        button.setActive(.white, ColorManager.blue ?? .blue)
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorManager.blue
        setConstraints()
    }
}


extension StartViewController {
    
    private func setConstraints() {
        setLogoImageView()
        setLoginButton()
        setSignupButton()
    }
    
    private func setLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(230)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(70)
            make.width.equalTo(243)
        }
    }
    
    private func setLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(53)
            make.height.equalTo(52)
            make.top.equalTo(logoImageView.snp.bottom).offset(196)
        }
    }
    
    private func setSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        
        signupButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(53)
            make.height.equalTo(52)
            make.top.equalTo(loginButton.snp.bottom).offset(24)
        }
    }
}

extension StartViewController {
    @objc func loginButtonTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    @objc func signupButtonTapped() {
        let vc = UINavigationController(rootViewController: SignupViewController())
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
}
