//
//  EpisodesTableViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

final class EpisodesTableViewController: UITableViewController {
    
    private let networkService = NetworkService()
    private var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EpisodeCell.self)
        getEpisodes()
    }
    
    private func getEpisodes() {
        networkService.getEpisodes() { [weak self] result in
            switch result {
            case .success(let response):
                self?.episodes = response.results
                self?.tableView?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Table view data source
extension EpisodesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(EpisodeCell.self, indexPath: indexPath)
        let episode = episodes[indexPath.row]
        cell.configure(with: episode)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = EpisodeDetailsTableViewController()
        detailsView.setupData(for: episodes[indexPath.row])
        
        navigationController?.pushViewController(detailsView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
