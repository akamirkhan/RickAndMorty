//
//  RickAndMortyEndpoint.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 29.01.2023.
//

import Foundation

extension Endpoint {
    static func characters(for page: Int) -> Self {
        Endpoint(
            path: "character",
            queryItems: [URLQueryItem(name: "page", value: "\(page)")]
        )
    }
    
    static func characters(for ids: String) -> Self {
        Endpoint(path: "character/\(ids)")
    }
    
    static var episodes: Self {
        Endpoint(path: "episode")
    }
}
