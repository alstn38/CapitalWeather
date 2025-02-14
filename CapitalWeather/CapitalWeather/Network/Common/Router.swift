//
//  Router.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import Alamofire
import Foundation

protocol Router: URLRequestConvertible {
    associatedtype ErrorType: Error
    
    var url: URL? { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    
    func throwError(_ error: AFError) -> ErrorType
}
