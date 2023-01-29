//
//  RickAndMorthyService.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 29.01.2023.
//

import Foundation

final class RickAndMortyService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func getCharacters(for ids: String, completion: @escaping Handler<[Character]>) {
        networkService.makeRequest(to: .characters(for: ids), completion: completion)
    }
    
    func getCharacters(completion: @escaping Handler<Character.Container>) {
        networkService.makeRequest(to: .characters, completion: completion)
    }
    
    func getEpisodes(completion: @escaping Handler<Episode.Container>) {
        networkService.makeRequest(to: .episodes, completion: completion)
    }

}
