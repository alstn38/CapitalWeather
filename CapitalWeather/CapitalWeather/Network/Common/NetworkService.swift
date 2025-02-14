//
//  NetworkService.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Alamofire

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    func request<T: Router, U: Decodable>(
        router: T,
        responseType: U.Type,
        completionHandler: @escaping (Result<U, T.ErrorType>) -> Void
    ) {
        AF.request(router)
            .validate(statusCode: 200...299)
            .responseDecodable(of: U.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                    
                case .failure(let error):
                    let error = router.throwError(error)
                    completionHandler(.failure(error))
                }
            }
    }
}
