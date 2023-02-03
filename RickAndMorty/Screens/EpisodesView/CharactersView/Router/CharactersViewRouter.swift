//
//  CharactersViewRouter.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 2/1/23.
//

import Foundation

final class CharactersViewRouter {
    weak var view: ModuleTransitionable?
    
    func pushCharacterInfoModule(for character: Character) {
        let module = CharacterInfoViewConfigurator.create(for: character)
        view?.pushModule(module: module, animation: true)
    }
    
}
