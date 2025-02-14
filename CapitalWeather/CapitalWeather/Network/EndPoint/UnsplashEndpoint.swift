//
//  UnsplashEndpoint.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Alamofire
import Foundation

enum UnsplashEndpoint: Router {
    case search(query: String)
}

extension UnsplashEndpoint {
    typealias ErrorType = UnsplashAPIError
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.unsplashBaseURL
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": Secret.unsplashClientID]
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let query):
            return [
                "query": query
            ]
        }
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
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 500: return .internalServerError
        case 503: return .serviceUnavailable
        default: return .unownedError
        }
    }
}
