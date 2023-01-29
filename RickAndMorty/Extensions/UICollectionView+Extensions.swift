//
//  UICollectionView+Extensions.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 28.01.2023.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerFooter<T: UICollectionReusableView>(_: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: T.self)
        )
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: T.self), for: indexPath
        ) as! T
    }
}
