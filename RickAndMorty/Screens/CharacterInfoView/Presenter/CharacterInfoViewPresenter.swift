//
//  CharacterInfoViewPresenter.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 2/1/23.
//

import Foundation

final class CharacterInfoViewPresenter {

    private let sections = Section.allCases
    private let character: Character
    private var characterInfo: [[String]] = []
    
    weak var view: CharacterInfoViewController?
    
    init(character: Character) {
        self.character = character
    }
    
    func viewLoaded() {
        view?.initialSetup()
        view?.setupData(for: character)
        updateCharacterInfo()
    }
    
    var numberOfSections: Int {
        sections.count
    }
    
    func numberOfRows(for section: Int) -> Int {
        sections[section].rows.count
    }
    
    func titleForSection(for section: Int) -> String {
        "\(sections[section])".uppercased()
    }
    
    private func updateCharacterInfo() {
        characterInfo = [
            [character.species, character.gender, character.status],
            [character.location.name, character.origin.name]
        ]
    }
    
    func row(for section: Int, and row: Int) -> SectionRow {
        return sections[section].rows[row]
    }
    
    func info(for section: Int, and row: Int) -> String {
        characterInfo[section][row]
    }

}
