//
//  SceneDelegate.swift
//  CapitalWeather
//
//  Created by 강민수 on 2/13/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let localCountryService = LocalCountryService()
        let weatherNetworkService = WeatherNetworkService()
        let viewModel = MainWeatherViewModel(
            localCountryService: localCountryService,
            weatherNetworkService: weatherNetworkService
        )
        let mainWeatherViewController = MainWeatherViewController(viewModel: viewModel)
        let mainNavigationController = UINavigationController(rootViewController: mainWeatherViewController)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
