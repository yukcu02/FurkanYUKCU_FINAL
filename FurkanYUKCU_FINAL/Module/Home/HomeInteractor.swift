//
//  HomeInteractor.swift
//  FurkanYUKCU_FINAL
//
//  Created by Furkan Yükcü on 8.06.2023.
//

import Foundation

typealias MusicSourcesResult = Result<MusicData, NetworkError>

protocol HomeInteractorProtocol: AnyObject {
    func fetchMusic()
}

protocol HomeInteractorOutputProtocol {
    func fetchMusicOutput(_ result: MusicSourcesResult)
}

fileprivate var musicService: MusicServiceProtocol = API()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusic() {
        musicService.fetchMusic { [weak self] result in
            guard let self = self else { return }
            
            let transformedResult = result.map { musicData in
                MusicData(resultCount: 1, results: [musicData])
            }
            
            self.output?.fetchMusicOutput(transformedResult)
        }
    }
}


//extension HomeInteractor: HomeInteractorProtocol {
//
//    func fetchMusic() {
//        musicService.fetchMusic { [weak self] result in
//            guard let self else { return }
//            self.output?.fetchMusicOutput(result)
//        }
//    }
//}



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
