//
//  EpisodesTableViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

final class EpisodesTableViewController: UITableViewController, ModuleTransitionable {
    
    private let presenter: EpisodesViewPresenter
    
    init(presenter: EpisodesViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EpisodeCell.self)
        presenter.viewLoaded()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
}

// MARK: - Table view data source
extension EpisodesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(EpisodeCell.self, indexPath: indexPath)
        let episode = presenter.episode(for: indexPath.row)
        cell.configure(with: episode)
        presenter.paginate(using: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = EpisodesFooterView()
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return presenter.footerViewSize
    }
    
}
