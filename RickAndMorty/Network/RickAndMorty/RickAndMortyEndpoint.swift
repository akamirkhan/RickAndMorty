//
//  RickAndMortyEndpoint.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 29.01.2023.
//

import Foundation

extension Endpoint {
    static var characters: Self {
        Endpoint(path: "character")
    }
    
    static func characters(for ids: String) -> Self {
        Endpoint(path: "character/\(ids)")
    }
    
    static var episodes: Self {
        Endpoint(path: "episode")
    }
}
