//
//  CharactersCollectionViewController.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 23.01.2023.
//

import UIKit

final class CharactersCollectionViewController: UICollectionViewController {
    
    private let networkService = RickAndMortyService()
    private var characters: [Character] = []
    
    private var isFetchInProgress = false
    private var isAllCharactersLoaded = false
    private var currentPage = 1
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerFooter(CharacterFooterView.self)
        collectionView.register(CharacterCell.self)
        getCharacters()
    }
    
    private func getCharacters() {
        guard !isFetchInProgress, !isAllCharactersLoaded else { return }
        
        networkService.getCharacters(for: currentPage) { [weak self] result in
            self?.isFetchInProgress = true
            switch result {
            case .success(let response):
                self?.handleResponse(response)
            case .failure(let error):
                self?.isFetchInProgress = false
                print(error)
            }
        }
    }
    
    private func handleResponse(_ response: Character.Container) {
        currentPage += 1
        isFetchInProgress = false
        characters.append(contentsOf: response.results)
        isAllCharactersLoaded = characters.count == response.info.count
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeue(CharacterCell.self, indexPath: indexPath)
        
        let character = characters[indexPath.item]
        item.configure(with: character)
        if indexPath.item == characters.count - 1 {
            getCharacters()
        }
        
        return item
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let infoViewController = CharacterInfoViewController()
        infoViewController.setupData(for: characters[indexPath.row])
        navigationController?.pushViewController(infoViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueFooter(CharacterFooterView.self, indexPath: indexPath)
        return footerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let size = isAllCharactersLoaded ? CGSize() : CGSize(width: view.frame.width, height: 60)
        return size
    }

}
