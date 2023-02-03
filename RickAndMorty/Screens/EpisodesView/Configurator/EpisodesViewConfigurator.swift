//
//  EpisodesViewConfigurator.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 02.02.2023.
//

import UIKit

final class EpisodesViewConfigurator {
    
    static func create() -> EpisodesTableViewController {
        let router = EpisodesViewRouter()
        let networkService = RickAndMortyService()
        let presenter = EpisodesViewPresenter(router: router, networkService: networkService)
        let view = EpisodesTableViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
