//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

final class CharactersCollectionViewController: UICollectionViewController, ModuleTransitionable {
    
    private let presenter: CharactersViewPresenter
    
    init(presenter: CharactersViewPresenter, collectionViewLayout layout: UICollectionViewLayout) {
        self.presenter = presenter
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerFooter(CharacterFooterView.self)
        collectionView.register(CharacterCell.self)
        presenter.viewLoaded()
    }
    
    func reload() {
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeue(CharacterCell.self, indexPath: indexPath)
        let character = presenter.character(for: indexPath.item)
        item.configure(with: character)
        presenter.paginate(using: indexPath.item)
        
        return item
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelect(at: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueFooter(CharacterFooterView.self, indexPath: indexPath)
        return footerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return presenter.footerViewSize
    }

}
