//
//  SearchViewModel.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/16/25.
//

import Foundation

final class SearchViewModel: InputOutputModel {
    
    typealias ID = Int
    
    struct Input {
        let viewDidLoad: CurrentValueRelay<Void>
        
    }
    
    struct Output {
        let updateWeatherSearch: CurrentValueRelay<Void>
        let presentError: CurrentValueRelay<(title: String, message: String)>
    }
    
    private let output = Output(
        updateWeatherSearch: CurrentValueRelay(()),
        presentError: CurrentValueRelay((title: "", message: ""))
    )
    
    private(set) var searchWeatherEntityArray: [SearchWeatherEntity] = []
    private var cityInfoArray: [CityInfoEntity] = []
    private var cityWeatherDictionary: [ID: CurrentWeatherEntity] = [:]
    
    private let localCountyService: LocalCountryServiceInterface
    private let weatherNetworkService: WeatherNetworkServiceInterface
    
    init(localCountyService: LocalCountryServiceInterface, weatherNetworkService: WeatherNetworkServiceInterface) {
        self.localCountyService = localCountyService
        self.weatherNetworkService = weatherNetworkService
    }

    func transform(from input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            fetchAllCountryInfo()
        }
        
        return output
    }
    
    /// Local json에서 id, 국가명, 도시명을 가져오는 메서드
    /// success - 가져온 id를 활용하여 현재 날씨를 가져온다.
    /// failure - Present Alert
    private func fetchAllCountryInfo() {
        localCountyService.fetchCountryInfo { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let cityInfoArray):
                self.cityInfoArray = cityInfoArray
                fetchAllWeatherInfo()
                
            case .failure(let error):
                output.presentError.send((
                    title: StringLiterals.Alert.localError,
                    message: error.localizedDescription
                ))
            }
        }
    }
    
    /// Local에 저장되어있는 id를 이용하여 현재 날씨 값을 가져와 저장하는 메서드
    private func fetchAllWeatherInfo() {
        let dispatchGroup = DispatchGroup()
        let totalCount = cityInfoArray.count
        let totalPage = Int((totalCount + 19) / 20)
        
        for currentPage in 1...totalPage {
            dispatchGroup.enter()
            
            let startIndex = (currentPage - 1) * 20
            let endIndex = min(currentPage * 20, totalCount)
            
            let groupIDArray = cityInfoArray[startIndex..<endIndex].map { $0.id }
            weatherNetworkService.fetchCurrentWeatherInfo(group: groupIDArray) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let currentWeatherEntity):
                    dispatchGroup.leave()
                    for (id, currentWeather) in zip(groupIDArray, currentWeatherEntity) {
                        cityWeatherDictionary[id] = currentWeather
                    }
                    
                case .failure(let error):
                    output.presentError.send((
                        title: StringLiterals.Alert.networkError,
                        message: error.localizedDescription
                    ))
                }
            }
        }
        
        dispatchGroup.notify(queue: .global()) { [weak self] in
            guard let self else { return }
            makeSearchWeatherInfo()
        }
    }
    
    /// json의 초기 값과 id에 대한 날씨의 정보를 대입하여 searchModel을 만드는 메서드
    private func makeSearchWeatherInfo() {
        for cityInfo in cityInfoArray {
            guard let currentWeather = cityWeatherDictionary[cityInfo.id] else {
                output.presentError.send((
                    title: StringLiterals.Alert.networkError,
                    message: "데이터를 불러오는데 문제가 발생했습니다."
                ))
                return
            }
            
            let searchWeather = SearchWeatherEntity(
                cityInfoEntity: cityInfo,
                currentWeatherEntity: currentWeather
            )
            searchWeatherEntityArray.append(searchWeather)
        }
        output.updateWeatherSearch.send(())
    }
}
