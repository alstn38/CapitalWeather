//
//  MainWeatherViewModel.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/15/25.
//

import Foundation

final class MainWeatherViewModel: InputOutputModel {

    struct Input {
        let viewDidLoad: CurrentValueRelay<Void>
        let refreshButtonDidTap: CurrentValueRelay<Void>
        let searchButtonDidTap: CurrentValueRelay<Void>
    }
    
    struct Output {
        let selectCountryName: CurrentValueRelay<String>
        let currentDate: CurrentValueRelay<Void>
        let presentError: CurrentValueRelay<(title: String, message: String)>
    }
    
    private let output = Output(
        selectCountryName: CurrentValueRelay(""),
        currentDate: CurrentValueRelay(()),
        presentError: CurrentValueRelay((title: "", message: ""))
    )
    
    private(set) var currentDateString: String = ""
    
    private let currentCityID: Int
    private let localCountyService: LocalCountyServiceInterface
    
    init(currentCityID: Int = UserDefaultManager.shared.selectCityID, localCountyService: LocalCountyServiceInterface) {
        self.currentCityID = currentCityID
        self.localCountyService = localCountyService
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            fetchCountryName(at: currentCityID)
            fetchCurrentDate()
        }
        
        return output
    }
    
    /// Local json에서 일치하는 id의 국가명, 도시명을 가져오는 메서드
    private func fetchCountryName(at id: Int) {
        localCountyService.fetchCountryInfo(at: currentCityID) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let cityInfoEntity):
                let selectedCountryName = [cityInfoEntity.countryName, cityInfoEntity.cityName].joined(separator: ", ")
                output.selectCountryName.send(selectedCountryName)
                
            case .failure(let error):
                output.presentError.send((
                    title: StringLiterals.Alert.localError,
                    message: error.localizedDescription
                ))
            }
        }
    }
    
    /// 현재 시간을 M월 d일(E) a h시 m분형식으로 가져오는 메서드
    private func fetchCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "M월 d일(E) a h시 m분"

        let date = Date()
        let formattedDate = dateFormatter.string(from: date)
        currentDateString = formattedDate
        output.currentDate.send(())
    }
}

/*
 input
 - viewDidLoad
 - refreshButton
 - searchButton
 
 output
 - json에서 나라 이름, 도시 가져오기
 - 현재 시간 formatting
 - 오늘의 날씨 정보 5개값
 - 오늘의 description을 검색해서 링크 던져주기
 */
