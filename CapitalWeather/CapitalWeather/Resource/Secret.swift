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
        guard let accessToken = Bundle.main.infoDictionary?["UNSPLASH_CLIENT_ID"] as? String else {
            fatalError("UNSPLASH_CLIENT_ID ERROR")
        }
        return accessToken
    }()
    
    static let openWeatherBaseURL: String = {
        guard let accessToken = Bundle.main.infoDictionary?["OPENWEATHER_BASE_URL"] as? String else {
            fatalError("OPENWEATHER_BASE_URL ERROR")
        }
        return accessToken
    }()
    
    static let openWeatherAppID: String = {
        guard let accessToken = Bundle.main.infoDictionary?["OPENWEATHER_APP_ID"] as? String else {
            fatalError("OPENWEATHER_APP_ID ERROR")
        }
        return accessToken
    }()
    
    static let openWeatherIconURL: String = {
        guard let accessToken = Bundle.main.infoDictionary?["OPENWEATHER_ICON_URL"] as? String else {
            fatalError("OPENWEATHER_ICON_URL ERROR")
        }
        return accessToken
    }()
}
