//
//  HomePresenter.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func music(_ index: Int) -> Music?
    func didSelectRowAt(index: Int)
}

final class HomePresenter {
   
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var music: [Music] = []
    
    init(
         view: HomeViewControllerProtocol,
         router: HomeRouterProtocol,
         interactor: HomeInteractorProtocol)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("iTunes Search")
        fetchMusic()
    }
    
    func numberOfItems() -> Int {
        music.count
    }
    
    func music(_ index: Int) -> Music? {
        return music[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = music(index) else { return }
        router.navigate(.detail(source: source))
    }
    
    private func fetchMusic() {
        view.showLoadingView()
        interactor.fetchMusic()
    }

}
extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchMusicOutput(_ result: MusicSourcesResult) {
        
        view.hideLoadingView()
        
        switch result {
        case .success(let response):
            guard let musicData = response.results else {
                view.showError("Invalid music data")
                return
            }
            self.music = musicData
            view.reloadData()
        case .failure(let error):
            view.showError(error.localizedDescription)
        }
    }
}


//extension HomePresenter: HomeInteractorOutputProtocol {
//    
//    func fetchMusicOutput(_ result: MusicSourcesResult) {
//        
//        view.hideLoadingView()
//        
//        switch result {
//        case .success(let response):
//            self.music = response.result
//            view.reloadData()
//        case .failure(let error):
//            view.showError(error.localizedDescription)
//        }
//    }    
//}
