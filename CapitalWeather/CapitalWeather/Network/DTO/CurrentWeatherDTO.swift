//
//  CurrentWeatherDTO.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

struct CurrentWeatherDTO: Decodable {
    let weather: [Weather]
    let weatherTemperature: WeatherTemperature
    let wind: Wind
    let weatherSun: WeatherSun
    
    enum CodingKeys: String, CodingKey {
        case weather
        case weatherTemperature = "main"
        case wind
        case weatherSun = "sys"
    }
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct WeatherTemperature: Decodable {
    let currentTemperature: Double
    let feelsTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case feelsTemperature = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
}

struct WeatherSun: Decodable {
    let sunrise: Int
    let sunset: Int
}

struct Wind: Decodable {
    let speed: Double
}
