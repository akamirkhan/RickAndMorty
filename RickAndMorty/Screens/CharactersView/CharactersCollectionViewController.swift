//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

final class CharactersCollectionViewController: UICollectionViewController {
    
    private let networkService = NetworkService()
    private var characters: [Character] = []
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CharacterCell.self)
        getCharacter()
    }
    
    private func getCharacter() {
        networkService.getCharacters() { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters = response.results
                self?.collectionView?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension CharactersCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CharacterCell.self, indexPath: indexPath)
        
        let character = characters[indexPath.item]
        cell.configure(with: character)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infoViewController = CharacterInfoViewController()
        infoViewController.setupData(for: characters[indexPath.row])
        navigationController?.pushViewController(infoViewController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
