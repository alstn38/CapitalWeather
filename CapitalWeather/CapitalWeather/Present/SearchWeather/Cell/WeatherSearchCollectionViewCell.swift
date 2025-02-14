//
//  WeatherSearchCollectionViewCell.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import UIKit
import SnapKit

final class WeatherSearchCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    
    private let cityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "서울" // TODO: 삭제
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let countryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대한민국" // TODO: 삭제
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let temperatureInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "최저 20° 최고 28°" // TODO: 삭제
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray // TODO: 삭제
        return imageView
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "20.1°" // TODO: 삭제
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .weatherBlue)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            cityTitleLabel,
            countryTitleLabel,
            temperatureInfoLabel,
            weatherIconImageView,
            currentTemperatureLabel
        )
    }
    
    private func configureLayout() {
        cityTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        countryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cityTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(15)
        }
        
        temperatureInfoLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(15)
        }
        
        weatherIconImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(40)
        }
        
        currentTemperatureLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(15)
        }
    }
}
