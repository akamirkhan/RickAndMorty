//
//  Episode.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 27.01.2023.
//

import UIKit

struct Episode: Codable {
    let name: String
    let episode: String
    let airDate: String
    let characters: [String]
}

extension Episode {
    struct Container: Codable {
        let results: [Episode]
    }
}
