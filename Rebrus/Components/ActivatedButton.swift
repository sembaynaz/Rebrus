//
//  ActivatedButton.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 19/01/2024.
//

import UIKit

class ActivatedButton: UIButton {
    private var activeColor: UIColor = ColorManager.red!
    private var inactiveColor: UIColor = ColorManager.grey!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}
//MARK: - UI setups
extension ActivatedButton {
    private func setUp() {
        self.isEnabled = false
        let font = UIFont(name: "Montserrat-Bold", size: 15)
        self.titleLabel?.font = font
        self.layer.cornerRadius = 12
        self.backgroundColor = inactiveColor
        self.setTitleColor(.white, for: .normal)
    }
    
    func setActive(_ isActive: Bool) {
        self.isEnabled = isActive
        self.backgroundColor = isActive ? activeColor : inactiveColor
    }
}

