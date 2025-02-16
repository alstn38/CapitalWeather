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
    
    func toEntity() -> CurrentWeatherEntity {
        return CurrentWeatherEntity(
            icon: self.weather.first?.icon ?? "",
            description: self.weather.first?.description ?? "",
            currentTemperature: self.weatherTemperature.currentTemperature,
            minTemperature: self.weatherTemperature.minTemperature,
            maxTemperature: self.weatherTemperature.maxTemperature,
            feelsTemperature: self.weatherTemperature.feelsTemperature,
            sunrise: self.weatherSun.sunrise,
            sunset: self.weatherSun.sunset,
            humidity: self.weatherTemperature.humidity,
            windSpeed: self.wind.speed,
            photoDescription: self.weather.first?.photoDescription ?? ""
        )
    }
}

struct Weather: Decodable {
    let photoDescription: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case photoDescription = "main"
        case description
        case icon
    }
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
