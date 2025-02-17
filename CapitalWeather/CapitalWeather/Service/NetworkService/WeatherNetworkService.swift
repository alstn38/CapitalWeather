//
//  WeatherNetworkService.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/16/25.
//

import Foundation

protocol WeatherNetworkServiceInterface {
    func fetchCurrentWeatherInfo(
        at cityID: Int,
        completionHandler: @escaping (Result<CurrentWeatherEntity, WeatherAPIError>) -> Void
    )
    
    func fetchCurrentWeatherInfo(
        group cityIDArray: [Int],
        completionHandler: @escaping (Result<[CurrentWeatherEntity], WeatherAPIError>) -> Void
    )
    
    func fetchTodayPhotoLink(
        with description: String,
        completionHandler: @escaping (Result<SearchPhotoEntity, UnsplashAPIError>) -> Void
    )
}

final class WeatherNetworkService: WeatherNetworkServiceInterface {
    
    func fetchCurrentWeatherInfo(
        at cityID: Int,
        completionHandler: @escaping (Result<CurrentWeatherEntity, WeatherAPIError>) -> Void
    ) {
        let endpoint = WeatherEndpoint.weatherInfo(id: cityID)
        
        NetworkService.shared.request(
            router: endpoint,
            responseType: CurrentWeatherDTO.self) { result in
                switch result {
                case .success(let currentWeatherDTO):
                    let currentWeatherEntity = currentWeatherDTO.toEntity()
                    completionHandler(.success(currentWeatherEntity))
                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func fetchCurrentWeatherInfo(
        group cityIDArray: [Int],
        completionHandler: @escaping (Result<[CurrentWeatherEntity], WeatherAPIError>) -> Void
    ) {
        let endpoint = WeatherEndpoint.weatherGroupInfo(idArray: cityIDArray)
        
        NetworkService.shared.request(
            router: endpoint,
            responseType: CurrentWeatherListDTO.self) { result in
                switch result {
                case .success(let currentWeatherListDTO):
                    completionHandler(.success(currentWeatherListDTO.list.map { $0.toEntity() }))
                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func fetchTodayPhotoLink(
        with description: String,
        completionHandler: @escaping (Result<SearchPhotoEntity, UnsplashAPIError>) -> Void
    ) {
        let endpoint = UnsplashEndpoint.search(query: description)
        
        NetworkService.shared.request(
            router: endpoint,
            responseType: UnsplashSearchPhotoDTO.self) { result in
                switch result {
                case .success(let searchPhotoDTO):
                    let searchPhotoEntity = searchPhotoDTO.toEntity()
                    completionHandler(.success(searchPhotoEntity))
                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
