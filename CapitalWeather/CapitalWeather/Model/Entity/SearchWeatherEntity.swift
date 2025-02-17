//
//  SearchWeatherEntity.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/17/25.
//

import Foundation

struct SearchWeatherEntity {
    let cityInfoEntity: CityInfoEntity
    let currentWeatherEntity: CurrentWeatherEntity
    
    func hasSearchText(text: String) -> Bool {
        return cityInfoEntity.cityKoreanName.contains(text)
        || cityInfoEntity.cityEnglishName.lowercased().contains(text)
        || cityInfoEntity.countryKoreanName.contains(text)
        || cityInfoEntity.countryEnglishName.lowercased().contains(text)
    }
}
