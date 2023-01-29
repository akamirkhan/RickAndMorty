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
                CharactersCollectionViewController(collectionViewLayout: createLayout()),
                title: "Characters",
                image: "person.crop.square.filled.and.at.rectangle.fill"
            ),
            createController(
                EpisodesTableViewController(),
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
    
    private func createLayout() -> UICollectionViewLayout {
        let width = UIScreen.main.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
