//
//  UITableView+Extensions.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 26.01.2023.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }

}
