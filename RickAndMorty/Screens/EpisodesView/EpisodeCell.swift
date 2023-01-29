//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 27.01.2023.
//

import UIKit

final class EpisodeCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let dataLabel = UILabel()
    private let episodeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with episode: Episode) {
        nameLabel.text = episode.name
        dataLabel.text = episode.airDate
        episodeLabel.text = episode.episode
    }
    
    private func setupViews() {
        accessoryType = .disclosureIndicator
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .brown
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        dataLabel.textAlignment = .right
        dataLabel.textColor = .systemGray2
        episodeLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, episodeLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        contentView.addSubviews(stackView, dataLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dataLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dataLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 8),
        ])
    }
    
}
