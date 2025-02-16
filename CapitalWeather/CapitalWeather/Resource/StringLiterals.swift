//
//  StringLiterals.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import Foundation

enum StringLiterals {
    
    enum NavigationItem {
        static let backButtonTitle: String = ""
    }
    
    enum Alert {
        static let confirm: String = "확인"
        static let localError: String = "로컬 오류"
        static let networkError: String = "네트워크 오류"
    }
    
    enum MainWeatherView {
        static let moreInfoButtonTitle: String = "5일간 예보 보러가기"
    }
    
    enum SearchView {
        static let title: String = "도시 검색"
        static let searchPlaceholder: String = "지금, 날씨가 궁금한 곳은?"
    }
}
