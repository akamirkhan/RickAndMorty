//
//  CharactersViewConfigurator.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 2/1/23.
//

import UIKit

final class CharactersViewConfigurator {

    // MARK: - Internal methods
    static func create() -> CharactersCollectionViewController {
        let router = CharactersViewRouter()
        let networkService = RickAndMortyService()
        let presenter = CharactersViewPresenter(router: router, networkService: networkService)
        let view = CharactersCollectionViewController(presenter: presenter, collectionViewLayout: createLayout())

        presenter.view = view
        router.view = view

        return view
    }
    
    private static func createLayout() -> UICollectionViewLayout {
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

