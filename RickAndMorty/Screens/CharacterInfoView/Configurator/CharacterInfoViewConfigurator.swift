//
//  CharacterInfoViewConfigurator.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 2/1/23.
//

import Foundation

final class CharacterInfoViewConfigurator {

    // MARK: - Internal methods
    static func create(for character: Character) -> CharacterInfoViewController {
        let presenter = CharacterInfoViewPresenter(character: character)
        let view = CharacterInfoViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
