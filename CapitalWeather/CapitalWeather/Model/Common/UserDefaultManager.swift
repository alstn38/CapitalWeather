//
//  UserDefaultManager.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: self.key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

final class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private init() { }
    
    enum UserDefaultKey: String {
        case selectCityID
        case selectCityName
        
        var key: String {
            return rawValue
        }
    }
    
    @UserDefault(key: UserDefaultKey.selectCityID.key, defaultValue: 1835848)
    var selectCityID
    
    @UserDefault(key: UserDefaultKey.selectCityName.key, defaultValue: "대한민국, 서울")
    var selectCityName
}
