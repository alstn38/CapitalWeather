//
//  SearchViewController.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private let input: SearchViewModel.Input

    private let weatherSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = StringLiterals.SearchView.searchPlaceholder
        return searchController
    }()
    
    private lazy var weatherSearchCollectionView: UICollectionView = {
        let screenWidth = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: screenWidth - 40, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.input = SearchViewModel.Input(viewDidLoad: CurrentValueRelay(()))
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
        configureCollectionView()
        configureView()
        configureHierarchy()
        configureLayout()
        
        input.viewDidLoad.send(())
    }
    
    private func configureBindingData() {
        let output = viewModel.transform(from: input)
        
        output.updateWeatherSearch.bind { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.weatherSearchCollectionView.reloadData()
            }
        }
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = StringLiterals.SearchView.title
        navigationItem.searchController = weatherSearchController
    }
    
    private func configureCollectionView() {
        weatherSearchCollectionView.delegate = self
        weatherSearchCollectionView.dataSource = self
        
        weatherSearchCollectionView.register(
            WeatherSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: WeatherSearchCollectionViewCell.identifier
        )
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .weatherLightBlue)
    }
    
    private func configureHierarchy() {
        view.addSubview(weatherSearchCollectionView)
    }
    
    private func configureLayout() {
        weatherSearchCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchWeatherEntityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherSearchCollectionViewCell.identifier,
            for: indexPath
        ) as? WeatherSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureView(with: viewModel.searchWeatherEntityArray[indexPath.item])
        return cell
    }
}
