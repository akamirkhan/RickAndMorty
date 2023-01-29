//
//  CustomErrors.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

enum CustomError: Error {
    case serverError
    case decodingError
    case invalidURL
    case invalidData
    
    var message: String {
        switch self {
        case .serverError:
            return "Проверьте ваше интернет соеденение"
        case .decodingError:
            return "Ошибка декодирования"
        case .invalidURL:
            return "Неправильный адрес сервера"
        case .invalidData:
            return "Не удалось получить данные с сервера"
        }
    }
}
