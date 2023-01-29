//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 29.01.2023.
//

import UIKit

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/" + path
        components.queryItems = queryItems
        
        return components.url
    }
}
