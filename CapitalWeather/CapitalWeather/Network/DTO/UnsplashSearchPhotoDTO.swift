//
//  UnsplashSearchPhotoDTO.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

struct UnsplashSearchPhotoDTO: Decodable {
    let results: [Picture]
    
    func toEntity() -> SearchPhotoEntity {
        return SearchPhotoEntity(
            photoLink: self.results.first?.urls.smallSizeLink ?? "",
            width: self.results.first?.width ?? 0,
            height: self.results.first?.height ?? 0
        )
    }
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
