//
//  Button.swift
//  Rebrus
//
//

import Foundation
import UIKit

class Button: UIButton {
    private var backColor: UIColor = ColorManager.blue!
    private var titleColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        custumize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        custumize()
    }
}

extension Button {
    private func custumize() {
        let font = UIFont(name: "Montserrat-Bold", size: 20)
        titleLabel?.font = font
        layer.cornerRadius = 12
        backgroundColor = backColor
        setTitleColor(
            titleColor,
            for: .normal
        )
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
}

extension Button {
    func setActive(_ backColor: UIColor, _ titleColor: UIColor) {
        self.backColor = backColor
        self.titleColor = titleColor
        custumize()
    }
}
