//
//  CurrentWeatherEntity.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/16/25.
//

import Foundation

struct CurrentWeatherEntity {
    let icon: String
    let description: String
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let feelsTemperature: Double
    let sunrise: Int
    let sunset: Int
    let humidity: Int
    let windSpeed: Double
}
