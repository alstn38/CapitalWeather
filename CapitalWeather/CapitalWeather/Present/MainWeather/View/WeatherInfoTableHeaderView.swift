//
//  WeatherInfoTableHeaderView.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import SnapKit

final class WeatherInfoTableHeaderView: UITableViewHeaderFooterView, ReusableViewProtocol {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(date: String) {
        dateLabel.text = date
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .weatherLightBlue)
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
