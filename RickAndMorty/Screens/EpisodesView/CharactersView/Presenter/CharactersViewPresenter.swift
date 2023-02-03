//
//  CharactersViewPresenter.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 2/1/23.
//

import UIKit

final class CharactersViewPresenter {
    
    private let router: CharactersViewRouter
    private let networkService: RickAndMortyService
    private var characters: [Character] = []
    
    private var isFetchInProgress = false
    private var isAllCharactersLoaded = false
    private var currentPage = 1
    
    weak var view: CharactersCollectionViewController?
    
    init(router: CharactersViewRouter, networkService: RickAndMortyService) {
        self.router = router
        self.networkService = networkService
    }
    
    var numberOfItems: Int {
        characters.count
    }
    
    var footerViewSize: CGSize {
        return isAllCharactersLoaded ? CGSize() : CGSize(width: view?.view.frame.width ?? 0, height: 60)
    }
    
    func viewLoaded() {
        getCharacters()
    }
    
    func didSelect(at row: Int) {
        let character = characters[row]
        router.pushCharacterInfoModule(for: character)
    }
    
    func character(for index: Int) -> Character {
        return characters[index]
    }
    
    func paginate(using index: Int) {
        if index == characters.count - 1 {
            getCharacters()
        }
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
        isAllCharactersLoaded = currentPage == response.info.pages
        view?.reload()
    }
    
}
