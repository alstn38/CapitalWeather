//
//  MainWeatherViewController.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import SnapKit

final class MainWeatherViewController: UIViewController {
    
    private let weatherInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedSectionHeaderHeight = 80
        tableView.estimatedSectionFooterHeight = 80
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "대한민국, 서울"
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonDidTap)
        )
        
        let refreshButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(refreshButtonDidTap)
        )
        
        searchButton.tintColor = .black
        refreshButton.tintColor = .black
        navigationItem.rightBarButtonItems = [searchButton, refreshButton]
    }
    
    private func configureTableView() {
        weatherInfoTableView.delegate = self
        weatherInfoTableView.dataSource = self
        
        weatherInfoTableView.register(
            WeatherInfoTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: WeatherInfoTableHeaderView.identifier
        )
        
        weatherInfoTableView.register(
            WeatherInfoTableFooterView.self,
            forHeaderFooterViewReuseIdentifier: WeatherInfoTableFooterView.identifier
        )
        
        weatherInfoTableView.register(
            WeatherInfoTableViewCell.self,
            forCellReuseIdentifier: WeatherInfoTableViewCell.identifier
        )
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .weatherLightBlue)
    }
    
    private func configureHierarchy() {
        view.addSubview(weatherInfoTableView)
    }
    
    private func configureLayout() {
        weatherInfoTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - @objc func
    @objc private func refreshButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func searchButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherInfoTableViewCell.identifier,
            for: indexPath
        ) as? WeatherInfoTableViewCell else { return UITableViewCell() }
        
        cell.configureView(.todayPhoto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: WeatherInfoTableHeaderView.identifier
        ) as? WeatherInfoTableHeaderView else { return nil }
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: WeatherInfoTableFooterView.identifier
        ) as? WeatherInfoTableFooterView else { return nil }
        return footerView
    }
}
