//
//  Secret.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Foundation

enum Secret {
    
    static let unsplashBaseURL: String = {
        guard let urlString = Bundle.main.infoDictionary?["UNSPLASH_BASE_URL"] as? String else {
            fatalError("UNSPLASH_BASE_URL ERROR")
        }
        
        return urlString
    }()
    
    static let unsplashClientID: String = {
        guard let clientID = Bundle.main.infoDictionary?["UNSPLASH_CLIENT_ID"] as? String else {
            fatalError("UNSPLASH_CLIENT_ID ERROR")
        }
        
        return clientID
    }()
    
    static let openWeatherBaseURL: String = {
        guard let urlString = Bundle.main.infoDictionary?["OPENWEATHER_BASE_URL"] as? String else {
            fatalError("OPENWEATHER_BASE_URL ERROR")
        }
        
        return urlString
    }()
    
    static let openWeatherAppID: String = {
        guard let appID = Bundle.main.infoDictionary?["OPENWEATHER_APP_ID"] as? String else {
            fatalError("OPENWEATHER_APP_ID ERROR")
        }
        
        return appID
    }()
    
    static func openWeatherIconURL(with icon: String) -> String {
        guard let urlString = Bundle.main.infoDictionary?["OPENWEATHER_ICON_URL"] as? String else {
            fatalError("OPENWEATHER_ICON_URL ERROR")
        }
        
        return urlString + "/img/wn/\(icon)@2x.png"
    }
}
