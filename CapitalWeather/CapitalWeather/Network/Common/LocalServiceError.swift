//
//  LocalServiceError.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

enum LocalServiceError: Error {
    case invalidPath
    case decodeError
    case notFound
}

extension LocalServiceError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidPath:
            return "invalidPath"
        case .decodeError:
            return "decoded Error"
        case .notFound:
            return "notFount"
        }
    }
}
