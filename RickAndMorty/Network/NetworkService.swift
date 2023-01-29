//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit
import Kingfisher

final class NetworkService {
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    typealias Completion<T: Decodable> = (Result<T, CustomError>) -> Void
    
    func getCharacters(for ids: String, completion: @escaping Completion<[Character]>) {
        loadData(from: "character/\(ids)", completion: completion)
    }
    
    func getCharacters(completion: @escaping Completion<Character.Container>) {
        loadData(from: "character", completion: completion)
    }
    
    func getEpisodes(completion: @escaping Completion<Episode.Container>) {
        loadData(from: "episode", completion: completion)
    }
    
    private func loadData<Model: Decodable>(from path: String, completion: @escaping Completion<Model>) {
        guard let url = URL(string: baseUrl + path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { response, _, error in
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            guard let response = response else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(Model.self, from: response)
                DispatchQueue.main.async { completion(.success(data)) }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
    
}
