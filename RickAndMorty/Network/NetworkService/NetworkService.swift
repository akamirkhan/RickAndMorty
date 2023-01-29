//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

typealias Handler<T: Codable> = (Result<T, NetworkError>) -> Void

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

final class NetworkService {
    
    func makeRequest<Model: Codable>(
        to endpoint: Endpoint,
        for method: HttpMethod = .get,
        with body: Data? = nil,
        completion: @escaping Handler<Model>
    ) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { response, _, error in
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
