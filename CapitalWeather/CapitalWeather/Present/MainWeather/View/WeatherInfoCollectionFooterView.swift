//
//  WeatherInfoCollectionFooterView.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import SnapKit

protocol WeatherInfoCollectionFooterViewDelegate: AnyObject {
    func weatherInfoCollectionFooterViewDelegate(_ collectionReusableView: UICollectionReusableView)
}

final class WeatherInfoCollectionFooterView: UICollectionReusableView, ReusableViewProtocol {
    
    weak var delegate: WeatherInfoCollectionFooterViewDelegate?
    
    private let moreInfoButton: UIButton = {
        var imageConfiguration = UIImage.SymbolConfiguration(pointSize: 10)
        
        var titleAttribute = AttributedString.init(StringLiterals.MainWeatherView.moreInfoButtonTitle)
        titleAttribute.font = .systemFont(ofSize: 13.0, weight: .medium)
        
        var configuration = UIButton.Configuration.plain()
        configuration.preferredSymbolConfigurationForImage = imageConfiguration
        configuration.attributedTitle = titleAttribute
        configuration.image = UIImage(
            systemName: "chevron.down.2",
            withConfiguration: UIImage.SymbolConfiguration(weight: .medium)
        )
        configuration.baseForegroundColor = .black
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5
        
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(moreInfoButton)
    }
    
    private func configureLayout() {
        moreInfoButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func moreInfoButtonDidTap(_ sender: UIButton) {
        delegate?.weatherInfoCollectionFooterViewDelegate(self)
    }
}
