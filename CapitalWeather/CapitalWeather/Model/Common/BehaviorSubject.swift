//
//  BehaviorSubject.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

final class BehaviorSubject<T> {
    
    private(set) var value: T {
        didSet {
            closure?(value)
        }
    }
    
    private var closure: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
        closure(value)
    }
    
    func send(_ value: T) {
        self.value = value
    }
}
