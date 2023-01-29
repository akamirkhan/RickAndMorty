//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

typealias Handler<T: Decodable> = (Result<T, NetworkError>) -> Void

final class NetworkService {
    
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    
    private let session = URLSession(configuration: .default)
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPResponse
        }

        switch httpResponse.statusCode {
        case 200: return data ?? Data()
        case 400...499:
            throw NetworkError.requestFailed(httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            fatalError("Unhandled HTTP Response Status code: \(httpResponse.statusCode)")
        }
    }
    
    func makeRequest<Model: Decodable>(to endpoint: Endpoint, completion: @escaping Handler<Model>) {
        guard let url = endpoint.url else {
            completion(.failure(.incorrectUrl))
            return
        }
        
        let handler: Completion = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                let response = try self.decoder.decode(Model.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                completion(.failure((error as? NetworkError) ?? .decodingError(error)))
            }
        }

        session.dataTask(with: url, completionHandler: handler).resume()
    }
    
}
