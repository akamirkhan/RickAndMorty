//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 24.01.2023.
//

import UIKit
import Kingfisher

final class CharacterCell: UICollectionViewCell {
    
    private let characterImage = UIImageView()
    private let characterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        characterImage.layer.cornerRadius = 4
        characterImage.clipsToBounds = true
        characterImage.contentMode = .scaleAspectFill
        
        characterLabel.numberOfLines = 0
        characterLabel.font = .preferredFont(forTextStyle: .footnote)
        characterLabel.textAlignment = .center
    }
    
    func configure(with character: Character) {
        characterImage.kf.indicatorType = .activity
        characterImage.kf.setImage(with: URL(string: character.image))
        characterLabel.text = character.name
    }
    
    private func setupLayout() {
        contentView.addSubviews(characterImage, characterLabel)
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            characterImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            characterLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 4),
            characterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
