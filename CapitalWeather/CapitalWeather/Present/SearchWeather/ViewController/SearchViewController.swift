//
//  SearchViewController.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/14/25.
//

import UIKit
import SnapKit

protocol SearchViewControllerDelegate: AnyObject {
    func viewController(_ viewController: UIViewController, updateIDAt weatherID: Int)
}

final class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private let input: SearchViewModel.Input
    weak var delegate: SearchViewControllerDelegate?

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
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private let noSearchResultGuideLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiterals.SearchView.noSearchResultGuideText
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.input = SearchViewModel.Input(
            viewDidLoad: CurrentValueRelay(()),
            searchTextDidChange: CurrentValueRelay(("")),
            searchButtonDidTap: CurrentValueRelay(()),
            searchWeatherCellDidTap: CurrentValueRelay(0)
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
        configureCollectionView()
        configureView()
        configureHierarchy()
        configureLayout()
        
        input.viewDidLoad.send(())
    }
    
    private func configureBindingData() {
        let output = viewModel.transform(from: input)
        
        output.updateWeatherSearch.bind { [weak self] hasValue in
            guard let self else { return }
            DispatchQueue.main.async {
                self.weatherSearchCollectionView.reloadData()
                self.weatherSearchCollectionView.isHidden = !hasValue
                self.noSearchResultGuideLabel.isHidden = hasValue
            }
        }
        
        output.dismissKeyboard.bind { [weak self] _ in
            guard let self else { return }
            view.endEditing(true)
        }
        
        output.moveToMainController.bind { [weak self] weatherID in
            guard let self else { return }
            delegate?.viewController(self, updateIDAt: weatherID)
            navigationController?.popViewController(animated: true)
        }
        
        output.presentError.bind { [weak self] (title, message) in
            guard let self else { return }
            presentAlert(title: title, message: message)
        }
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = StringLiterals.SearchView.title
        navigationItem.searchController = weatherSearchController
        weatherSearchController.searchBar.delegate = self
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
        view.addSubviews(
            weatherSearchCollectionView,
            noSearchResultGuideLabel
        )
    }
    
    private func configureLayout() {
        weatherSearchCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        noSearchResultGuideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(120)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredWeatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherSearchCollectionViewCell.identifier,
            for: indexPath
        ) as? WeatherSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureView(with: viewModel.filteredWeatherArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        input.searchWeatherCellDidTap.send(indexPath.item)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        input.searchTextDidChange.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input.searchButtonDidTap.send(())
    }
}
