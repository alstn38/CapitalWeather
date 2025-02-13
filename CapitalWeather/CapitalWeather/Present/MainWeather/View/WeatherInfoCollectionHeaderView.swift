//
//  WeatherInfoCollectionHeaderView.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import SnapKit

final class WeatherInfoCollectionHeaderView: UICollectionReusableView, ReusableViewProtocol {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 29일(수) 오후 3시 12분" // TODO: 삭제
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        return label
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
        addSubview(dateLabel)
    }
    
    private func configureLayout() {
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
}
