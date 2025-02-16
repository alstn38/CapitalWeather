//
//  MainWeatherViewController.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import SnapKit

final class MainWeatherViewController: UIViewController {
    
    private let viewModel: MainWeatherViewModel
    private let input: MainWeatherViewModel.Input
    
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
    
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
        self.input = MainWeatherViewModel.Input(
            viewDidLoad: CurrentValueRelay(()),
            refreshButtonDidTap: CurrentValueRelay(()),
            searchButtonDidTap: CurrentValueRelay(())
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBindingData()
        configureNavigation()
        configureTableView()
        configureView()
        configureHierarchy()
        configureLayout()
        input.viewDidLoad.send(())
    }
    
    private func configureBindingData() {
        let output = viewModel.transform(from: input)
        
        output.selectCountryName.bind { [weak self] countryName in
            guard let self else { return }
            navigationItem.title = countryName
        }
        
        output.presentError.bind { [weak self] (title, message) in
            guard let self else { return }
            presentAlert(title: title, message: message)
        }
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = StringLiterals.NavigationItem.backButtonTitle
        
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
        let searchViewController = SearchViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
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
