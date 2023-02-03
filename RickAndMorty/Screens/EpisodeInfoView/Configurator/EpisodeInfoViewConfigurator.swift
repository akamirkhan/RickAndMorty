//
//  EpisodeInfoViewConfigurator.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 02.02.2023.
//

import UIKit

final class EpisodeInfoViewConfigurator {
    
    // MARK: - Internal methods
    static func create(for episode: Episode) -> EpisodeInfoTableViewController {
        let networkService = RickAndMortyService()
        let presenter = EpisodeInfoViewPresenter(networkService: networkService, episode: episode)
        let view = EpisodeInfoTableViewController(presenter: presenter)

        presenter.view = view

        return view
    }
    
}
