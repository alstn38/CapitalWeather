//
//  LocalService.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

final class LocalService {
    
    static let shared = LocalService()
    
    private init() { }
    
    func loadJsonData<T: Decodable>(
        fileName: String,
        responseType: T.Type,
        completionHandler: @escaping (Result<T, LocalServiceError>) -> Void
    ) {
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(
            forResource: fileName,
            withExtension: extensionType
        ) else {
            completionHandler(.failure(.invalidPath))
            return
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(decodedData))
        } catch {
            completionHandler(.failure(.decodeError))
        }
    }
}
