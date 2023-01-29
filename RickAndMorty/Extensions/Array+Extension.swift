//
//  Array+Extension.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 28.01.2023.
//

import UIKit

extension Array {
    subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
}
