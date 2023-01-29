//
//  CharacterInfoViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let tableView = UITableView()
    private let sections = Section.allCases
    private var characterInfo: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViews()
        setupLayout()
    }
    
    func setupData(for character: Character) {
        title = character.name
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: character.image))
        characterInfo = [
            [character.species, character.gender, character.status],
            [character.location.name, character.origin.name]
        ]
    }
    
    private func setupTableView() {
        tableView.register(CharacterInfoCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
    }
    
    private func setupLayout() {
        view.addSubviews(imageView, tableView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: - UITableView delegate & datasource
extension CharacterInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(sections[section])".uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CharacterInfoCell.self)
        let row = sections[indexPath.section].rows[indexPath.row]
        let info = characterInfo[indexPath.section][indexPath.row]
        cell.configure(with: row, infoText: info)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
