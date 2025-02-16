//
//  WeatherInfoTableViewCell.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import Kingfisher
import SnapKit

final class WeatherInfoTableViewCell: UITableViewCell, ReusableViewProtocol {
    
    private let infoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private let todayWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray // TODO: 삭제
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureHierarchy()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ type: MainWeatherViewModel.WeatherInfoType) {
        configureLayout(type)
        
        switch type {
        case .weather(let icon, let description):
            configureWeather(icon: icon, description: description)
            
        case .currentTemperature(let current, let min, let max):
            configureTemperature(current: current, min: min, max: max)
            
        case .feelsLikeTemperature(let feel):
            configureTemperature(feel: feel)
            
        case .sunRiseAndSetTime(let cityName, let rise, let set):
            configureSunTime(cityName: cityName, rise: rise, set: set)
            
        case .humidityAndWindSpeed(let humidity, let windSpeed):
            configureHumidityAndWindSpeed(humidity: humidity, windSpeed: windSpeed)
            
        case .todayPhoto(let photoLink):
            print("todayPhoto")
        }
    }
    
    private func configureWeather(icon: String, description: String) {
        weatherIconImageView.kf.setImage(with: URL(string: Secret.openWeatherIconURL(with: icon)))
        
        let weatherInfoText = "오늘의 날씨는 \(description) 입니다"
        weatherInfoLabel.text = weatherInfoText
    }
    
    private func configureTemperature(current: String, min: String, max: String) {
        let weatherInfoText = "현재 온도는 \(current) 입니다"
        weatherInfoLabel.text = weatherInfoText
        
        let weatherTemperatureText = "최저 \(min) 최고 \(max)"
        weatherTemperatureLabel.text = weatherTemperatureText
    }
    
    private func configureTemperature(feel: String) {
        let weatherInfoText = "체감 온도는 \(feel) 입니다"
        weatherInfoLabel.text = weatherInfoText
    }
    
    private func configureSunTime(cityName: String, rise: String, set: String) {
        let weatherInfoText = "\(cityName)의 일출 시각은 \(rise), 일몰 시각은 \(set)입니다."
        weatherInfoLabel.text = weatherInfoText
    }
    
    private func configureHumidityAndWindSpeed(humidity: String, windSpeed: String) {
        let weatherInfoText = "습도는 \(humidity)이고, 풍속은 \(windSpeed) 입니다"
        weatherInfoLabel.text = weatherInfoText
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .weatherLightBlue)
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            infoBackgroundView,
            weatherIconImageView,
            weatherInfoLabel,
            weatherTemperatureLabel,
            todayWeatherImageView
        )
    }
    
    private func configureLayout(_ type: MainWeatherViewModel.WeatherInfoType) {
        infoBackgroundView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.top.equalTo(weatherInfoLabel).offset(-12)
            $0.bottom.equalTo(weatherInfoLabel).offset(12)
        }
        
        switch type {
        case .weather:
            weatherIconImageView.snp.makeConstraints {
                $0.leading.equalTo(infoBackgroundView)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(40)
            }
            
            weatherInfoLabel.snp.makeConstraints {
                $0.leading.equalTo(weatherIconImageView.snp.trailing)
                $0.trailing.equalTo(infoBackgroundView).inset(20)
                $0.centerY.equalToSuperview()
            }
            
        case .currentTemperature:
            weatherInfoLabel.snp.makeConstraints {
                $0.leading.equalTo(infoBackgroundView).offset(20)
                $0.centerY.equalToSuperview()
            }
            
            weatherTemperatureLabel.snp.makeConstraints {
                $0.leading.equalTo(weatherInfoLabel.snp.trailing).offset(10)
                $0.trailing.equalTo(infoBackgroundView).inset(20)
                $0.bottom.equalTo(weatherInfoLabel)
            }
            
        case .feelsLikeTemperature, .sunRiseAndSetTime, .humidityAndWindSpeed:
            weatherInfoLabel.snp.makeConstraints {
                $0.horizontalEdges.equalTo(infoBackgroundView).inset(20)
                $0.centerY.equalToSuperview()
            }
            
        case .todayPhoto:
            infoBackgroundView.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.lessThanOrEqualToSuperview().inset(20)
                $0.verticalEdges.equalToSuperview().inset(5)
                $0.top.equalTo(weatherInfoLabel).offset(-12)
                $0.bottom.equalTo(todayWeatherImageView).offset(12)
            }
            
            weatherInfoLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(17)
                $0.horizontalEdges.equalTo(infoBackgroundView).inset(20)
            }
            
            todayWeatherImageView.snp.makeConstraints {
                $0.top.equalTo(weatherInfoLabel.snp.bottom).offset(10)
                $0.horizontalEdges.equalToSuperview().inset(40)
                $0.height.equalTo(150)
                $0.horizontalEdges.equalTo(infoBackgroundView).inset(20)
            }
        }
    }
}
