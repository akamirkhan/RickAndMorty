//
//  UIView+Extensions.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 25.01.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
