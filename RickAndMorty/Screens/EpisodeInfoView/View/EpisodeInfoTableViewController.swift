//
//  EpisodeInfoTableViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 27.01.2023.
//

import UIKit

final class EpisodeInfoTableViewController: UITableViewController, ModuleTransitionable {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let presenter: EpisodeInfoViewPresenter
    
    init(presenter: EpisodeInfoViewPresenter) {
        self.presenter = presenter
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EpisodeInfoCell.self)
        presenter.viewLoaded()
    }
    
    func setupData(for episode: Episode) {
        title = episode.name
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func setupActivityIndicator() {
        activityIndicator.startAnimating()
        tableView.addSubviews(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
}

// MARK: - Table view data source
extension EpisodeInfoTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(for: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.title(for: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(EpisodeInfoCell.self, indexPath: indexPath)
        let row = presenter.row(for: indexPath.section, and: indexPath.row)
        let info = presenter.info(for: indexPath.row)
        let isCharacterRow = presenter.isCharacterRow(indexPath.section)
        cell.configure(with: row, episodeInfo: info, isCharacterRow: isCharacterRow)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
