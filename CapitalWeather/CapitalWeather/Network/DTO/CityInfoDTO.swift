//
//  CityInfoDTO.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

struct CityInfoListDTO: Decodable {
    let cities: [CityInfoDTO]
}

struct CityInfoDTO: Decodable {
    let city: String
    let cityName: String
    let country: String
    let countryName: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case city
        case cityName = "ko_city_name"
        case country
        case countryName = "ko_country_name"
        case id
    }
    
    func toEntity() -> CityInfoEntity {
        return CityInfoEntity(
            cityEnglishName: self.city,
            cityKoreanName: self.cityName,
            countryEnglishName: self.country,
            countryKoreanName: self.countryName,
            id: self.id
        )
    }
}
