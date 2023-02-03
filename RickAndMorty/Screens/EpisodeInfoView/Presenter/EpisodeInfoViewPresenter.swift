//
//  EpisodeInfoViewPresenter.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 02.02.2023.
//

import UIKit

final class EpisodeInfoViewPresenter {
    
    private let networkService: RickAndMortyService
    private let episode: Episode
    
    private var episodeInfo: [String?] = []
    private var sections: [Sections] = [.info]
    
    weak var view: EpisodeInfoTableViewController?
    
    init(networkService: RickAndMortyService, episode: Episode) {
        self.networkService = networkService
        self.episode = episode
    }
    
    var numberOfSections: Int {
        sections.count
    }
    
    func viewLoaded() {
        view?.setupActivityIndicator()
        updateCharacterInfo()
        loadCharacters()
    }
    
    func isCharacterRow(_ section: Int) -> Bool {
        return sections[section] != .info
    }
    
    func numberOfRows(for section: Int) -> Int {
        sections[section].rows.count
    }
    
    func title(for section: Int) -> String {
        sections[section].title
    }
    
    func row(for section: Int, and row: Int) -> SectionRow {
        return sections[section].rows[row]
    }
    
    func info(for row: Int) -> String {
        return episodeInfo[row, default: ""] ?? ""
    }
    
    private func updateCharacterInfo() {
        episodeInfo = [episode.name, episode.airDate, episode.episode]
    }
    
    private func loadCharacters() {
        var ids = String()
        episode.characters.forEach { character in
            guard let characterId = URL(string: character)?.lastPathComponent else { return }
            ids.isEmpty ? ids.append(characterId) : ids.append(",\(characterId)")
        }
        
        networkService.getCharacters(for: ids) { [weak self] result in
            switch result {
            case .success(let response):
                let characters = response.map { CharacterRow(row: .init(title: $0.name, icon: $0.image))}
                self?.sections.append(.characters(characters: characters))
                self?.view?.stopAnimating()
                self?.view?.reload()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
