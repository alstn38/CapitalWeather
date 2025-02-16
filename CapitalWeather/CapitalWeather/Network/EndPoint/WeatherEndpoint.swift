//
//  WeatherEndpoint.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Alamofire
import Foundation

enum WeatherEndpoint: Router {
    case weatherInfo(id: Int)
    case currentWeather(latitude: Double, longitude: Double)
}

extension WeatherEndpoint {
    typealias ErrorType = WeatherAPIError
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.openWeatherBaseURL
    }
    
    var path: String {
        switch self {
        case .weatherInfo:
            return "/data/2.5/weather"
        case .currentWeather:
            return "/data/2.5/weather"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .weatherInfo:
            return .get
        case .currentWeather:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .weatherInfo(let id):
            return [
                "id": id,
                "appid": Secret.openWeatherAppID,
                "lang": "kr"
            ]
        case .currentWeather(let latitude, let longitude):
            return [
                "lat": latitude,
                "lon": longitude,
                "appid": Secret.openWeatherAppID,
                "lang": "kr"
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url else {
            throw ErrorType.invalidURL
        }
        
        do {
            var request = try URLRequest(url: url, method: method, headers: headers)
            request = try URLEncoding.default.encode(request, with: parameters)
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
