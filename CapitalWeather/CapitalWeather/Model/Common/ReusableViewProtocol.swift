//
//  ReusableViewProtocol.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import Foundation

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
