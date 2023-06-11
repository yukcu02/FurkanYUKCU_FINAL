//
//  HomeInteractor.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

protocol HomeInteractorProtocol {
    func fetchMusic()
}

protocol HomeInteractorOutputProtocol {
    func fetchMusicOutput(result: [Music])
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusic() {
        let musicRepository = MusicRepository()
        let music = musicRepository.fetchMusic() ?? [Music]()
        
        self.output?.fetchMusicOutput(result: music)
    }
}


//typealias MusicSourcesResult = Result<MusicData, NetworkError>
//
//
//protocol HomeInteractorProtocol: AnyObject {
//    func fetchMusic()
//}
//
//protocol HomeInteractorOutputProtocol {
//    func fetchMusicOutput(_ result: MusicSourcesResult)
//}
//
//fileprivate var musicService: MusicServiceProtocol = API()
//
//final class HomeInteractor {
//    var output: HomeInteractorOutputProtocol?
//}
//
//extension HomeInteractor: HomeInteractorProtocol {
//
//    func fetchMusic() {
//        musicService.fetchMusic { [weak self] result in
//            guard let self else { return }
//            self.output?.fetchMusicOutput(result)
//        }
//    }
//}
