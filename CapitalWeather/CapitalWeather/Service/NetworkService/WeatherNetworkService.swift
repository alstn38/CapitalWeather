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
}
