//
//  UILabel+.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/17/25.
//

import UIKit

extension UILabel {
    
    func highlightText(for texts: String..., with color: UIColor) {
        guard let labelText = self.text else { return }
        let attributedString = NSMutableAttributedString(string: labelText)
        
        for text in texts {
            guard let range = labelText.range(of: text, options: .caseInsensitive) else { return }
            let nsRange = NSRange(range, in: labelText)
            attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
        }
        
        self.attributedText = attributedString
    }
    
    func boldText(for texts: String...) {
        guard let labelText = self.text else { return }
        let attributedString = NSMutableAttributedString(string: labelText)
        let fontSize = self.font.pointSize
        
        for text in texts {
            guard let range = labelText.range(of: text, options: .caseInsensitive) else { return }
            let nsRange = NSRange(range, in: labelText)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: nsRange)
        }
        
        self.attributedText = attributedString
    }
}
