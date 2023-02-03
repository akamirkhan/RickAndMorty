//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .brown
        setTabViewControllers()
    }
    
    private func setTabViewControllers() {
        viewControllers = [
            createController(
                CharactersViewConfigurator.create(),
                title: "Characters",
                image: "person.crop.square.filled.and.at.rectangle.fill"
            ),
            createController(
                EpisodesViewConfigurator.create(),
                title: "Episodes",
                image: "tv.fill"
            )
        ]
    }
    
    private func createController(
        _ controller: UIViewController,
        title: String,
        image: String
    ) -> UIViewController {
        controller.title = title
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        return UINavigationController(rootViewController: controller)
    }
    
}
