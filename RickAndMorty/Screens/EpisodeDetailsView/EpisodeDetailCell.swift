//
//  EpisodeDetailCell.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 27.01.2023.
//

import UIKit

final class EpisodeDetailCell: UITableViewCell {
    
    private let iconImage = UIImageView()
    private let titleLabel = UILabel()
    private let secondaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImage.image = nil
        iconImage.layer.cornerRadius = 0
        iconImage.contentMode = .center
        secondaryLabel.text = nil
    }
    
    func configure(with row: SectionRow, episodeInfo: String, isCharacterRow: Bool) {
        titleLabel.text = row.row.title
        
        if isCharacterRow {
            iconImage.kf.indicatorType = .activity
            iconImage.kf.setImage(with: URL(string: row.row.icon))
            iconImage.layer.cornerRadius = 15
            iconImage.contentMode = .scaleAspectFill
            iconImage.clipsToBounds = true
        } else {
            iconImage.image = UIImage(systemName: row.row.icon)
            secondaryLabel.text = episodeInfo
        }
    }
    
    private func setupViews() {
        iconImage.tintColor = .brown
        iconImage.contentMode = .center
        
        secondaryLabel.textAlignment = .right
        secondaryLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        secondaryLabel.textColor = .brown
        secondaryLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
    }
    
    private func setupLayout() {
        contentView.addSubviews(iconImage, titleLabel, secondaryLabel)
        
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 30),
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8),
            
            secondaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            secondaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            secondaryLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            secondaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
}
