//
//  UIView+.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
