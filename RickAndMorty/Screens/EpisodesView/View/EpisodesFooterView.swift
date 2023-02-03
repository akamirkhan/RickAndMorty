//
//  EpisodesFooterView.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 31.01.2023.
//

import UIKit

final class EpisodesFooterView: UIView {
    
    let activity = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activity)
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}



