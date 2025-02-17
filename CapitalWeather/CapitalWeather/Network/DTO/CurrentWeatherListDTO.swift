//
//  CurrentWeatherListDTO.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/17/25.
//

import Foundation

struct CurrentWeatherListDTO: Decodable {
    let count: Int
    let list: [CurrentWeatherDTO]
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case list
    }
}
