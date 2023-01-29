//
//  CharacterInfoCell.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

final class CharacterInfoCell: UITableViewCell {
    
    private let infoImage = UIImageView()
    private let titleLabel = UILabel()
    private let infoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        infoImage.tintColor = .brown
        infoImage.contentMode = .center
        
        infoLabel.textAlignment = .right
        infoLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        infoLabel.textColor = .brown
        infoLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
    }
    
    func configure(with row: SectionRow, infoText: String) {
        infoImage.image = UIImage(systemName: row.row.icon)
        titleLabel.text = row.row .title
        infoLabel.text = infoText
    }
    
    private func setupLayout() {
        contentView.addSubviews(infoImage, titleLabel, infoLabel)
        
        NSLayoutConstraint.activate([
            infoImage.widthAnchor.constraint(equalToConstant: 30),
            infoImage.heightAnchor.constraint(equalToConstant: 30),
            infoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(equalTo: infoImage.trailingAnchor, constant: 8),
            
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
}
