//
//  InputOutputModel.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

protocol InputOutputModel {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
