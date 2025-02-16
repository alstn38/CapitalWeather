//
//  WeatherIconEndPoint.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Alamofire
import Foundation

enum WeatherIconEndPoint: Router {
    case weatherIcon(icon: String)
}

extension WeatherIconEndPoint {
    typealias ErrorType = WeatherAPIError
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.openWeatherIconURL
    }
    
    var path: String {
        switch self {
        case .weatherIcon(let icon):
            return "/img/wn/\(icon)@2x.png"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .weatherIcon:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url else {
            throw ErrorType.invalidURL
        }
        
        do {
            var request = try URLRequest(url: url, method: method, headers: headers)
            
            if let parameters {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            }
            
            return request
        } catch {
            throw ErrorType.badRequest
        }
    }
    
    func throwError(_ error: AFError) -> ErrorType {
        if error.underlyingError is DecodingError {
            return .decodeError
        }
        
        switch error.responseCode {
        case 401: return .unauthorized
        case 404: return .notFound
        case 429: return .rateLimitExceeded
        case 500: return .internalServerError
        case 502: return .badGateway
        case 503: return .serviceUnavailable
        case 504: return .gatewayTimeout
        default: return .unownedError
        }
    }
}

