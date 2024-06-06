//
//  AlertViewController.swift
//  Rebrus
//
//

import Foundation
import UIKit

protocol AlertDelegate: AnyObject {
    func didAgreeButtonTapped()
}

protocol AlertSecondDelegate: AnyObject {
    func didAgreeButtonTappedSecond()
}

class AlertViewController: UIViewController {
    var imageName = ""
    var messageText = ""
    var activeButtonTitle = ""
    var cancelButtonTitle = ""
    let customVIew = AlertView()
    weak var delegate: AlertDelegate?
    weak var secondDelegate: AlertSecondDelegate?
    var isSecondDelegate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension AlertViewController {
    func setupUI() {
        view.addSubview(customVIew)
        customVIew.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customVIew.agreeButton.setTitle("\(activeButtonTitle)", for: .normal)
        customVIew.agreeButton.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        customVIew.cancelButton.setTitle("\(cancelButtonTitle)", for: .normal)
        customVIew.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        customVIew.messageLabel.text = messageText
        customVIew.logoImage.image = UIImage(named: imageName)
    }
}

    //MARK: Functionality
extension AlertViewController {
    @objc func cancelButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc func agreeButtonTapped() {
        if isSecondDelegate {
            secondDelegate?.didAgreeButtonTappedSecond()
        } else {
            delegate?.didAgreeButtonTapped()
        }
        
        dismiss(animated: false)
    }
}
