//
//  Character.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

struct Character: Codable {
    let name: String
    let image: String
    let species: String
    let gender: String
    let status: String
    let location: Location
    let origin: Location
}

extension Character {
    struct Container: Codable {
        let results: [Character]
    }
}

struct Location: Codable {
    let name: String
}
