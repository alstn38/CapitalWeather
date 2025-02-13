//
//  WeatherInfoTableViewCell.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
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
        imageView.backgroundColor = .gray // TODO: 삭제
        return imageView
    }()
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 날씨는 무엇무엇입니다." // TODO: 삭제
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최저 20° 최고 28°" // TODO: 삭제
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
    
    func configureView(_ type: weatherInfoCellType) {
        configureLayout(type)
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .weatherBlue)
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
    
    private func configureLayout(_ type: weatherInfoCellType) {
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
                $0.leading.equalTo(infoBackgroundView).offset(20)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(25)
            }
            
            weatherInfoLabel.snp.makeConstraints {
                $0.leading.equalTo(weatherIconImageView.snp.trailing).offset(10)
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

// MARK: - WeatherInfoTableViewCell View Type
extension WeatherInfoTableViewCell {
    
    enum weatherInfoCellType {
        case weather
        case currentTemperature
        case feelsLikeTemperature
        case sunRiseAndSetTime
        case humidityAndWindSpeed
        case todayPhoto
    }
}
