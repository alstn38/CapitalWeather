//
//  MainWeatherViewController.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit
import SnapKit

final class MainWeatherViewController: UIViewController {

    private let weatherInfoCollectionView: UICollectionView = {
        let spacing: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
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
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .weatherBlue)
    }
    
    private func configureHierarchy() {
        view.addSubview(weatherInfoCollectionView)
    }
    
    private func configureLayout() {
        weatherInfoCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - @objc func
    @objc private func refreshButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func searchButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
}
