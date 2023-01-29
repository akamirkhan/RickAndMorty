//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

enum NetworkError: Error, CustomStringConvertible {
    case nonHTTPResponse
    case requestFailed(Int)
    case serverError(Int)
    case networkError(Error)
    case decodingError(Error)
    case incorrectUrl

    var description: String {
        switch self {
        case .nonHTTPResponse: return "Non-HTTP response received"
        case .requestFailed(let status): return "Received HTTP \(status)"
        case .serverError(let status): return "Server Error - \(status)"
        case .networkError(let error): return "Failed to load the request: \(error)"
        case .decodingError(let decError): return "Failed to process response: \(decError)"
        case .incorrectUrl: return "An error occurred while processing the URL"
        }
    }
}
