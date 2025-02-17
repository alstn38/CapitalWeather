//
//  LocalCountyService.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/16/25.
//

import Foundation

protocol LocalCountryServiceInterface {
    func fetchCountryInfo(
        at id: Int,
        completionHandler: @escaping (Result<CityInfoEntity, LocalServiceError>) -> Void
    )
    func fetchCountryInfo(completionHandler: @escaping (Result<[CityInfoEntity], LocalServiceError>) -> Void)
}

final class LocalCountryService: LocalCountryServiceInterface {
    
    private let dummyFileName: String = "CityInfo"
    
    func fetchCountryInfo(
        at id: Int,
        completionHandler: @escaping (Result<CityInfoEntity, LocalServiceError>) -> Void
    ) {
        LocalService.shared.loadJsonData(
            fileName: dummyFileName,
            responseType: CityInfoListDTO.self
        ) { result in
                switch result {
                case .success(let cityInfoListDTO):
                    let cityInfoList = cityInfoListDTO.cities
                    let targetInfo = cityInfoList.first(where: { $0.id == id})
                    
                    if let targetInfo {
                        completionHandler(.success(targetInfo.toEntity()))
                    } else {
                        completionHandler(.failure(.notFound))
                    }
                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func fetchCountryInfo(completionHandler: @escaping (Result<[CityInfoEntity], LocalServiceError>) -> Void) {
        LocalService.shared.loadJsonData(
            fileName: dummyFileName,
            responseType: CityInfoListDTO.self
        ) { result in
                switch result {
                case .success(let cityInfoListDTO):
                    let cityInfoList = cityInfoListDTO.cities.map { $0.toEntity() }
                    completionHandler(.success(cityInfoList))
                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
