//
//  RoundOptionButton.swift
//  Rebrus
//
//

import UIKit

class RoundOptionButton: UIButton {
    private var isActive = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customize()
    }
}
//MARK: - UI setups
extension RoundOptionButton {
    private func customize() {
        self.setImage(UIImage(named: isActive ? "selectedButton" : "nonSelectedButton"), for: .normal)
    }
    
    func setActive(_ isActive: Bool) {
        self.isActive = isActive
        customize()
    }
}
