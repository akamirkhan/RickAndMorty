//
//  CharacterInfoViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

final class CharacterInfoViewController: UIViewController, ModuleTransitionable {
    
    private let imageView = UIImageView()
    private let tableView = UITableView()
    private let presenter: CharacterInfoViewPresenter
    
    init(presenter: CharacterInfoViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    func setupData(for character: Character) {
        title = character.name
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: character.image))
    }
    
    func initialSetup() {
        setupTableView()
        setupLayout()
        setupViews()
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
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForSection(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CharacterInfoCell.self)
        let row = presenter.row(for: indexPath.section, and: indexPath.row)
        let info = presenter.info(for: indexPath.section, and: indexPath.row)
        cell.configure(with: row, infoText: info)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
