//
//  EpisodesViewPresenter.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 02.02.2023.
//

import UIKit

final class EpisodesViewPresenter {
    
    private let router: EpisodesViewRouter
    private var networkService = RickAndMortyService()
    private var episodes: [Episode] = []
    
    private var isFetchInProgress = false
    private var isAllEpisodesLoaded = false
    private var currentPage = 1
    
    weak var view: EpisodesTableViewController?
    
    init(router: EpisodesViewRouter, networkService: RickAndMortyService) {
        self.router = router
        self.networkService = networkService
    }
    
    var numberOfSections: Int {
        episodes.count
    }
    
    var footerViewSize: CGFloat {
        isAllEpisodesLoaded ? 0 : 60
    }
    
    func viewLoaded() {
        getEpisodes()
    }
    
    func episode(for index: Int) -> Episode {
        return episodes[index]
    }
    
    func paginate(using index: Int) {
        if index == episodes.count - 1 {
            getEpisodes()
        }
    }
    
    func didSelect(at row: Int) {
        let episode = episodes[row]
        router.pushEpisodeInfoModule(for: episode)
    }
    
    private func getEpisodes() {
        guard !isFetchInProgress, !isAllEpisodesLoaded else { return }
        
        networkService.getEpisodes(for: currentPage) { [weak self] result in
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
    
    private func handleResponse(_ response: Episode.Container) {
        currentPage += 1
        isFetchInProgress = false
        episodes.append(contentsOf: response.results)
        isAllEpisodesLoaded = currentPage == response.info.pages
        view?.reload()
    }
    
}
