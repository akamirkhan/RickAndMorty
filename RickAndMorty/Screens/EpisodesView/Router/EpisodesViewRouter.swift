//
//  EpisodesViewRouter.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 02.02.2023.
//

import UIKit

final class EpisodesViewRouter {
    weak var view: ModuleTransitionable?
    
    func pushEpisodeInfoModule(for episode: Episode) {
        let module = EpisodeInfoViewConfigurator.create(for: episode)
        view?.pushModule(module: module, animation: true)
    }
    
}
