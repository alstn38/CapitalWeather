//
//  WeatherAPIError.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Foundation

enum WeatherAPIError: Error {
    case invalidURL
    case decodeError
    case badRequest
    case unauthorized
    case notFound
    case rateLimitExceeded
    case internalServerError
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case unownedError
}

extension WeatherAPIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .decodeError:
            return "decoded Error"
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "401 Unauthorized"
        case .notFound:
            return "404 Not Found"
        case .rateLimitExceeded:
            return "429 Too Many Requests"
        case .internalServerError:
            return "500 Internal Server Error"
        case .badGateway:
            return "502 Bad Gateway"
        case .serviceUnavailable:
            return "503 Service Unavailable"
        case .gatewayTimeout:
            return "504 Gateway Timeout"
        case .unownedError:
            return "unownedError"
        }
    }
}
