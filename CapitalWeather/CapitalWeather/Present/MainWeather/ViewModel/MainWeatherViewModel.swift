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
        let presentError: CurrentValueRelay<(title: String, message: String)>
    }
    
    private let output = Output(
        selectCountryName: CurrentValueRelay(""),
        presentError: CurrentValueRelay((title: "", message: ""))
    )
    
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
        }
        
        return output
    }
    
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
