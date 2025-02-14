//
//  UnsplashAPIError.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Foundation

enum UnsplashAPIError: Error {
    case invalidURL
    case decodeError
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case serviceUnavailable
    case unownedError
}

extension UnsplashAPIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .decodeError:
            return "decoded Error"
        case .badRequest:
            return "400 Bad Request"
        case .unauthorized:
            return "401 Unauthorized"
        case .forbidden:
            return "403 Forbidden"
        case .notFound:
            return "404 Not Found"
        case .internalServerError:
            return "500 Internal Server Error"
        case .serviceUnavailable:
            return "503 Service Unavailable"
        case .unownedError:
            return "unownedError"
        }
    }
}
