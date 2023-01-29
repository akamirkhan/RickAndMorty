//
//  EpisodeInfoTableViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 27.01.2023.
//

import UIKit

final class EpisodeInfoTableViewController: UITableViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let networkService = NetworkService()
    private var episodeInfo: [String?] = []
    var sections: [Sections] = [.info]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EpisodeInfoCell.self)
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        tableView.addSubviews(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    func setupData(for episode: Episode) {
        episodeInfo = [episode.name, episode.airDate, episode.episode]
        loadCharacters(for: episode)
    }
    
    private func loadCharacters(for episode: Episode) {
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
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - Table view data source
extension EpisodeInfoTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(EpisodeInfoCell.self, indexPath: indexPath)
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        let info = episodeInfo[indexPath.row, default: ""] ?? ""
        cell.configure(with: row, episodeInfo: info, isCharacterRow: section != .info)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
