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
        let updateWeatherInfo: CurrentValueRelay<Int>
    }
    
    struct Output {
        let selectCountryName: CurrentValueRelay<String>
        let moveToSearchController: CurrentValueRelay<Void>
        let updateCurrentDate: CurrentValueRelay<Void>
        let updateWeatherInfo: CurrentValueRelay<Void>
        let presentError: CurrentValueRelay<(title: String, message: String)>
    }
    
    private let output = Output(
        selectCountryName: CurrentValueRelay(""),
        moveToSearchController: CurrentValueRelay(()),
        updateCurrentDate: CurrentValueRelay(()),
        updateWeatherInfo: CurrentValueRelay(()),
        presentError: CurrentValueRelay((title: "", message: ""))
    )

    private(set) var currentDateString: String = ""
    private(set) var currentWeatherInfoArray: [WeatherInfoType] = []
    private var cityName: String = ""
    
    private var currentCityID: Int
    private let localCountryService: LocalCountryServiceInterface
    private let weatherNetworkService: WeatherNetworkServiceInterface

    init(
        localCountryService: LocalCountryServiceInterface,
        weatherNetworkService: WeatherNetworkServiceInterface
    ) {
        self.currentCityID = UserDefaultManager.shared.selectCityID
        self.localCountryService = localCountryService
        self.weatherNetworkService = weatherNetworkService
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            fetchCountryName(at: currentCityID)
            fetchCurrentDate()
            fetchCurrentWeatherInfo(at: currentCityID)
        }
        
        input.refreshButtonDidTap.bind { [weak self] _ in
            guard let self else { return }
            currentWeatherInfoArray.removeAll()
            fetchCountryName(at: currentCityID)
            fetchCurrentDate()
            fetchCurrentWeatherInfo(at: currentCityID)
        }
        
        input.searchButtonDidTap.bind { [weak self] _ in
            guard let self else { return }
            output.moveToSearchController.send(())
        }
        
        input.updateWeatherInfo.bind { [weak self] weatherID in
            guard let self else { return }
            UserDefaultManager.shared.selectCityID = weatherID
            currentCityID = weatherID
            currentWeatherInfoArray.removeAll()
            fetchCountryName(at: currentCityID)
            fetchCurrentDate()
            fetchCurrentWeatherInfo(at: currentCityID)
        }
        
        return output
    }
    
    /// Local json에서 일치하는 id의 국가명, 도시명을 가져오는 메서드
    private func fetchCountryName(at id: Int) {
        localCountryService.fetchCountryInfo(at: currentCityID) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let cityInfoEntity):
                let selectedCountryName = [cityInfoEntity.countryKoreanName, cityInfoEntity.cityKoreanName].joined(separator: ", ")
                cityName = cityInfoEntity.cityKoreanName
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
        output.updateCurrentDate.send(())
    }
    
    /// 선택된 도시의 현재 날시 정보를 가져오는 메서드
    private func fetchCurrentWeatherInfo(at id: Int) {
        weatherNetworkService.fetchCurrentWeatherInfo(at: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let currentWeatherEntity):
                updateWeatherDescription(from: currentWeatherEntity)
                updateWeatherTemperature(from: currentWeatherEntity)
                updateWeatherFeelsLikeTemperature(from: currentWeatherEntity)
                updateWeatherSunTime(from: currentWeatherEntity)
                updateHumidityAndWindSpeed(from: currentWeatherEntity)
                fetchTodayPhotoLink(with: currentWeatherEntity.photoDescription)
                
            case .failure(let error):
                output.presentError.send((
                    title: StringLiterals.Alert.networkError,
                    message: error.localizedDescription
                ))
            }
        }
    }
    
    /// 오늘의 날씨 사진 링크를 가져오는 메서드
    private func fetchTodayPhotoLink(with description: String) {
        weatherNetworkService.fetchTodayPhotoLink(with: description) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let searchPhotoEntity):
                let todayPhoto = WeatherInfoType.todayPhoto(photoLink: searchPhotoEntity.photoLink)
                currentWeatherInfoArray.append(todayPhoto)
                output.updateCurrentDate.send(())
                
            case .failure(let error):
                output.presentError.send((
                    title: StringLiterals.Alert.networkError,
                    message: error.localizedDescription
                ))
            }
        }
    }
    
    /// 현재 날씨 정보 설명을 업데이트하는 메서드
    private func updateWeatherDescription(from weatherInfo: CurrentWeatherEntity) {
        let weatherDescription = WeatherInfoType.weather(
            icon: weatherInfo.icon,
            description: weatherInfo.description
        )
        
        currentWeatherInfoArray.append(weatherDescription)
    }
    
    /// 현재 온도 정보를 업데이트하는 메서드
    private func updateWeatherTemperature(from weatherInfo: CurrentWeatherEntity) {
        let weatherTemperature = WeatherInfoType.currentTemperature(
            current: String(format: "%.1f°", weatherInfo.currentTemperature),
            min: String(format: "%.1f°", weatherInfo.minTemperature),
            max: String(format: "%.1f°", weatherInfo.maxTemperature)
        )
        
        currentWeatherInfoArray.append(weatherTemperature)
    }
    
    /// 현재 체감온도 정보를 업데이트하는 메서드
    private func updateWeatherFeelsLikeTemperature(from weatherInfo: CurrentWeatherEntity) {
        let weatherFeelsLikeTemperature = WeatherInfoType.feelsLikeTemperature(
            feel: String(format: "%.1f°", weatherInfo.feelsTemperature)
        )
        
        currentWeatherInfoArray.append(weatherFeelsLikeTemperature)
    }
    
    /// 현재 일출, 일몰 정보를 업데이트하는 메서드
    private func updateWeatherSunTime(from weatherInfo: CurrentWeatherEntity) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "a h시 mm분"
        
        let sunRiseDate = Date(timeIntervalSince1970: TimeInterval(weatherInfo.sunrise))
        let sunSetDate = Date(timeIntervalSince1970: TimeInterval(weatherInfo.sunset))
        let weatherSunInfoDescription = WeatherInfoType.sunRiseAndSetTime(
            cityName: cityName,
            rise: dateFormatter.string(from: sunRiseDate),
            set: dateFormatter.string(from: sunSetDate)
        )
        
        currentWeatherInfoArray.append(weatherSunInfoDescription)
    }
    
    /// 현재 습도, 풍속 정보를 업데이트하는 메서드
    private func updateHumidityAndWindSpeed(from weatherInfo: CurrentWeatherEntity) {
        let humidityAndWindSpeed = WeatherInfoType.humidityAndWindSpeed(
            humidity: "\(weatherInfo.humidity)%",
            windSpeed: String(format: "%.2fm/s", weatherInfo.windSpeed)
        )
        
        currentWeatherInfoArray.append(humidityAndWindSpeed)
    }
}

extension MainWeatherViewModel {
    
    enum WeatherInfoType {
        case weather(icon: String, description: String)
        case currentTemperature(current: String, min: String, max: String)
        case feelsLikeTemperature(feel: String)
        case sunRiseAndSetTime(cityName: String, rise: String, set: String)
        case humidityAndWindSpeed(humidity: String, windSpeed: String)
        case todayPhoto(photoLink: String)
    }
}
