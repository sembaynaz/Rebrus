//
//  Extensions.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 19/01/2024.
//

import Foundation
import UIKit

extension UIButton {
    func setTwoTexts(firstText: String, secondText: String) {
        let firstTextFont = UIFont(name: "Roboto-Regular", size: 18)
        let secondTextFont = UIFont(name: "Roboto-Regular", size: 16)
        
        let fullText = "\(firstText) \n\(secondText)"
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        attributedText.addAttribute(NSAttributedString.Key.font, value: firstTextFont!, range: NSRange(location: 0, length: firstText.count))
        
        attributedText.addAttribute(NSAttributedString.Key.font, value: secondTextFont!, range: NSRange(location: firstText.count + 1, length: secondText.count))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        self.setAttributedTitle(attributedText, for: .normal)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = .left
    }
}
