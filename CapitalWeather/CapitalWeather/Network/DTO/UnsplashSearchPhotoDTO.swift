//
//  UnsplashSearchPhotoDTO.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

struct UnsplashSearchPhotoDTO: Decodable {
    let results: [Picture]
}

struct Picture: Decodable {
    let width: Int
    let height: Int
    let urls: PrictureURL
}

struct PrictureURL: Decodable {
    let smallSizeLink: String

    enum CodingKeys: String, CodingKey {
        case smallSizeLink = "small"
    }
}
